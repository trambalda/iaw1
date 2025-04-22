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

    private let spacing: CGFloat = 16.0

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
        if view.isFirstResponder { return view }

        for subview in view.subviews {
            if let responder = findActiveResponder(in: subview) {
                return responder
            }
        }
        return nil
    }

    private func calculateOffset(currentViewController: UIViewController, keyboardHeight: CGFloat) -> CGFloat {
        let containerView = currentViewController.view
        let activeView = findActiveResponder(in: containerView ?? UIView())

        let safeAreaFrame = containerView?.safeAreaLayoutGuide.layoutFrame
        let visibleBottom = (safeAreaFrame?.origin.y ?? 0) + CGFloat(safeAreaFrame?.height ?? 0)
        let activeRect = activeView?.convert(activeView?.bounds ?? CGRect(), to: containerView)

        let visibleHeight = visibleBottom - keyboardHeight - spacing
        let offset = max(0, (activeRect?.maxY ?? 0) - visibleHeight)

        return offset
    }

    private func showAnimationView(
        duration: TimeInterval,
        currentViewController: UIViewController,
        newInset: CGFloat
    ) {
        var insets = currentViewController.additionalSafeAreaInsets
        insets.bottom = newInset
        currentViewController.additionalSafeAreaInsets = insets

        UIView.animate(
            withDuration: duration + 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.7,
            options: .curveEaseInOut
        ) {
            currentViewController.view.layoutIfNeeded()
        }
    }

    private func hideAnimationView(
        duration: TimeInterval,
        currentViewController: UIViewController
    ) {
        var insets = currentViewController.additionalSafeAreaInsets
        insets.bottom = 0
        currentViewController.additionalSafeAreaInsets = insets

        UIView.animate(
            withDuration: duration + 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.7,
            options: .curveEaseInOut
        ) {
            currentViewController.view.layoutIfNeeded()
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

        let currentViewController = rootViewController.topMostViewController()

        let offset = calculateOffset(
            currentViewController: currentViewController,
            keyboardHeight: keyboardFrameValue.height
        )

        let newInset: CGFloat = offset > 0 ? offset + spacing : 0

        showAnimationView(
            duration: animationDuration,
            currentViewController: currentViewController,
            newInset: newInset
        )
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let keyWindow = UIApplication.shared.keyWindowIsConnectedScenes,
            let rootViewController = keyWindow.rootViewController
        else { return }

        let currentViewController = rootViewController.topMostViewController()

        hideAnimationView(
            duration: animationDuration,
            currentViewController: currentViewController
        )
    }

    @objc private func dismissKeyboard() {
        UIApplication.shared.keyWindowIsConnectedScenes?.endEditing(true)
    }
}
