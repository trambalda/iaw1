
import UIKit

final class KeyboardService {

    private weak var viewController: UIViewController?
    private var keyboardHeight: CGFloat = 0

    private var isActive = false {
        didSet {
            guard let viewController = viewController else { return }
            viewController.view.frame.origin.y = self.isActive ? -self.keyboardHeight : 0
            viewController.view.layoutIfNeeded()
        }
    }

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController

        setupKeyboardObservers()
        hideKeyboardOnTapped()
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
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

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder
                .keyboardFrameEndUserInfoKey] as? CGRect else { return }

        keyboardHeight = keyboardFrame.height
        isActive = true
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        isActive = false
    }

    @objc private func dismissKeyboard() {
        viewController?.view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
