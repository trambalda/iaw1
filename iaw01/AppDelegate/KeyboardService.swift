import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    func adjustView(for responder: UIResponder?)
}

final class KeyboardService: KeyboardServiceProtocol {
    private weak var viewController: UIViewController?
    private var activeResponder: UIResponder?
    private var keyboardHeight: CGFloat = 0
    private let keyboardOffset: CGFloat = 30// Отступ от клавиатуры

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
        setupKeyboardObservers()
        hideKeyboardOnTapped()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func hideKeyboardOnTapped() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        viewController?.view.addGestureRecognizer(tap)
    }

    func adjustView(for responder: UIResponder?) {
        activeResponder = responder
        updateViewPosition()
    }

    private func updateViewPosition() {
        guard let responder = activeResponder as? UIView,
              let vc = viewController else { return }

        let responderFrame = responder.convert(responder.bounds, to: vc.view)
        let keyboardTopY = vc.view.bounds.height - keyboardHeight
        let desiredBottomY = keyboardTopY - keyboardOffset
        let offset = responderFrame.maxY - desiredBottomY

        UIView.animate(withDuration: 0.3) {
            vc.view.frame.origin.y = -offset
        }
    }

    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        keyboardHeight = keyboardFrame.height
        updateViewPosition()
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewController?.view.frame.origin.y = 0
        }
    }

    @objc private func dismissKeyboard() {
        viewController?.view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
