import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    var isEnabled: Bool { get set }
}

final class KeyboardService: KeyboardServiceProtocol {

    var isEnabled: Bool = true {
        didSet {
            isEnabled ? setupKeyboardObservers() : removeKeyboardObservers()
        }
    }

    private var originY: CGFloat = 0
    private let additionalOffset: CGFloat = 30

    init() {
        setupGesture()

        if isEnabled {
            setupKeyboardObservers()
        }
    }

    deinit {
        removeKeyboardObservers()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow),
            willHideSelector: #selector(keyboardWillHide)
        )
    }

    private func removeKeyboardObservers() {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }

    private func setupGesture() {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.windows.first
        else { return }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        window.addGestureRecognizer(tapGesture)
    }

    private func getCurrentViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first,
              let window = windowScene.windows.first
        else { return nil }

        var currentViewController = window.rootViewController

        while let presentedViewController = currentViewController?.presentedViewController {
            currentViewController = presentedViewController
        }

        return currentViewController
    }

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

    private func animateFromView(duration: TimeInterval, keyboardHeight: CGFloat) {
        guard
            let currentViewController = getCurrentViewController(),
            let containerView = currentViewController.view,
            let activeView = findActiveResponder(in: containerView)
        else { return }
        let activeRect = activeView.convert(activeView.bounds, to: containerView)
        let height = containerView.frame.height - keyboardHeight - additionalOffset
        let offset = max(0, activeRect.maxY - height)

        UIView.animate(
            withDuration: duration + 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.7,
            options: [.curveEaseInOut]
        ) { [weak self] in
            guard let self else { return }

            containerView.frame.origin.y = self.originY - offset
        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }

        animateFromView(duration: duration, keyboardHeight: keyboardFrame.height)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let currentViewController = getCurrentViewController(),
            let containerView = currentViewController.view
        else { return }

        UIView.animate(withDuration: duration) { [weak self] in
            guard let self else { return }
            containerView.frame.origin.y = self.originY
        }
    }

    @objc private func dismissKeyboard() {
        guard let currentViewController = getCurrentViewController() else { return }
        currentViewController.view.endEditing(true)
    }
}
