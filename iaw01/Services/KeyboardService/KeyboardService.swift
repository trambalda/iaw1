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

    private weak var activeTextField: UIView?

    private let spacing: CGFloat = 20

    init() {
        setupGesture()
        if isEnabled {
            setupKeyboardNotifications()
        }
    }

    deinit {
        removeKeyboardNotifications()
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupGesture() {
        guard let window = UIApplication.shared.keyWindowIsConnectedScenes else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        window.addGestureRecognizer(tapGesture)
    }

    private func findActiveResponder(in view: UIView) -> UIView? {
        if view.isFirstResponder {
            activeTextField = view
            return view
        }

        for subview in view.subviews {
            if let responder = findActiveResponder(in: subview) {
                return responder
            }
        }
        return nil
    }

    private func calculateOffset(currentViewController: UIViewController, keyboardHeight: CGFloat) -> CGFloat {
        if let containerView = currentViewController.view,
           let activeView = findActiveResponder(in: containerView) {

            let activeRect = activeView.convert(activeView.frame, to: containerView)
            let availableHeight = containerView.frame.height - keyboardHeight - spacing

            return max(0, activeRect.maxY - availableHeight + spacing)
        }

        return .zero
    }

    private func viewAnimation(
        duration: TimeInterval,
        currentViewController: UIViewController,
        offset: CGFloat
    ) {
        let transform = CGAffineTransform(translationX: 0, y: -offset)

        UIView.animate(
            withDuration: duration + 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.7,
            options: .curveEaseInOut
        ) {
            currentViewController.view.transform = transform
        }
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let keyWindow = UIApplication.shared.keyWindowIsConnectedScenes,
            let rootViewController = keyWindow.rootViewController
        else { return }

        if let activeField = activeTextField, activeField.isFirstResponder {
            return
        }

        let currentViewController = rootViewController.topMostViewController()

        let offset = calculateOffset(
            currentViewController: currentViewController,
            keyboardHeight: keyboardFrameValue.height
        )

        viewAnimation(
            duration: animationDuration,
            currentViewController: currentViewController,
            offset: offset > 0 ? offset + spacing : 0
        )
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard
            let keyWindow = UIApplication.shared.keyWindowIsConnectedScenes,
            let rootViewController = keyWindow.rootViewController
        else { return }

        activeTextField = nil
        let currentViewController = rootViewController.topMostViewController()

        currentViewController.view.transform = .identity
    }

    @objc private func dismissKeyboard() {
        UIApplication.shared.keyWindowIsConnectedScenes?.endEditing(true)
    }
}
