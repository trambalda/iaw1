import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    var isEnabled: Bool { get set }
}

final class KeyboardService: KeyboardServiceProtocol {

    var isEnabled: Bool = false {
        didSet {
            isEnabled ? setupKeyboardNotifications() : removeKeyboardNotifications()
        }
    }

    private weak var activeTextField: UITextField?

    private let spacing: CGFloat = 20
    private var lastOffset: CGFloat = 0.0

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture  = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        gesture.cancelsTouchesInView = false
        return gesture
    }()

    init() {
        setupGesture()

        if isEnabled {
            setupKeyboardNotifications()
        }
    }

    deinit {
        removeKeyboardNotifications()
        removeGesture()
    }

        //    MARK: - Setup Notification
    private func setupKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(textFieldDidBeginEditing(notification:)),
            name: UITextField.textDidBeginEditingNotification,
            object: nil
        )
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func textFieldDidBeginEditing(notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        activeTextField = textField
    }

        //    MARK: - Notification Actions
    @objc private func keyboardWillShow(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let rootViewController = UIApplication.rootViewController?.topMostViewController(),
            let activeResponder = activeTextField
        else { return }

        let offset = calculateViewOffset(
            activeView: activeResponder,
            containerView: rootViewController.view,
            keyboardHeight: keyboardFrameValue.height
        )

        guard lastOffset != offset else { return }
        lastOffset = offset

        print(offset)

        adjustView(
            duration: animationDuration,
            currentViewController: rootViewController,
            offset: offset
        )
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let rootViewController = UIApplication.rootViewController?.topMostViewController()
        else { return }

        restoreView(currentViewController: rootViewController, duration: animationDuration)
    }

    @objc private func dismissKeyboard() {
        UIApplication.keyWindowIsConnectedScenes?.endEditing(true)
        activeTextField = nil
    }

        //    MARK: - Calculate Offset
    private func calculateViewOffset(
        activeView: UIView,
        containerView: UIView,
        keyboardHeight: CGFloat
    ) -> CGFloat {
        let activeRect = activeView.convert(activeView.bounds, to: containerView)
        let safeAreaBottom = containerView.safeAreaInsets.bottom

        let keyboardOffset = containerView.bounds.height - keyboardHeight - spacing
        let availableHeight = keyboardOffset - safeAreaBottom

        return max(0, activeRect.maxY - availableHeight)
    }

        //    MARK: - Adjust and restore views
    private func adjustView(
        duration: TimeInterval,
        currentViewController: UIViewController,
        offset: CGFloat
    ) {
        let transform = CGAffineTransform(translationX: 0, y: -offset)

        UIView.animate(
            withDuration: duration + 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0,
            options: [.curveEaseOut, .beginFromCurrentState]
        ) {
            currentViewController.view.transform = transform
        }
    }

    private func restoreView(currentViewController: UIViewController, duration: TimeInterval) {
        UIView.animate(
            withDuration: duration + 0.2,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.9,
            options: [.curveEaseInOut, .beginFromCurrentState]
        ) {
            currentViewController.view.transform = .identity

        } completion: { [weak self] _ in
            self?.activeTextField = nil
            self?.lastOffset = .zero
        }
    }

}

    //    MARK: - Find Responder
extension KeyboardService {
    private func findActiveResponder(in view: UIView) -> UIView? {
        if view.isFirstResponder {
            return view
        }

        for subview in view.subviews {
            if let responder = findActiveResponder(in: subview) {
                return responder
            }
        }
        return nil
    }
}

    //    MARK: - Setup Gesture
extension KeyboardService {
    private func setupGesture() {
        guard let window = UIApplication.keyWindowIsConnectedScenes else { return }
        window.addGestureRecognizer(tapGesture)
    }

    private func removeGesture() {
        guard let window = UIApplication.keyWindowIsConnectedScenes else { return }
        window.removeGestureRecognizer(tapGesture)
    }
}
