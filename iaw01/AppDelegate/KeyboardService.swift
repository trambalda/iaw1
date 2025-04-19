import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    func viewController(_ view: UIView)
}

final class KeyboardService: KeyboardServiceProtocol {

    weak var viewController: UIView?

    private var originalY: CGFloat = 0
    private let additionalOffset: CGFloat = 30

    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }

    func viewController(_ view: UIView) {
        self.viewController = view
        self.originalY = view.frame.origin.y

        setupKeyboardObservers()
        setupGesture()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow),
            willHideSelector: #selector(keyboardWillHide)
        )
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        viewController?.addGestureRecognizer(tap)
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
        guard let viewController = viewController,
              let activeView = findActiveResponder(in: viewController) else { return }

        let activeRect = activeView.convert(activeView.bounds, to: viewController)
        let height = viewController.frame.height - keyboardHeight - additionalOffset
        let offset = max(0, activeRect.maxY - height)

        UIView.animate(
            withDuration: duration + 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.7,
            options: [.curveEaseInOut]
        ) {
            [weak self] in
            guard let self else { return }

            viewController.frame.origin.y = self.originalY - offset
        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }

        animateFromView(duration: duration, keyboardHeight: keyboardFrame.height)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let viewController = viewController
        else { return }

        UIView.animate(withDuration: duration) { [weak self] in
            guard let self else { return }
            viewController.frame.origin.y = self.originalY
        }
    }

    @objc private func dismissKeyboard() {
        viewController?.endEditing(true)
    }
}
