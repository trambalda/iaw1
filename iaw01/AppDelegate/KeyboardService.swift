import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    func adjustViewForKeyboard(_ view: UIView)
}

final class KeyboardService: KeyboardServiceProtocol {

    private weak var viewController: UIViewController?
    private weak var activeView: UIView?

    private var keyboardHeight: CGFloat = 0
    private var currentOffset: CGFloat = 0

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
        setupKeyboardObservers()
        hideKeyboardOnTapped()
    }

    func adjustViewForKeyboard(_ view: UIView) {
        guard view != activeView else { return }
        activeView = view

        if keyboardHeight > 0 {
            moveToNewActiveView()
        }
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    private func hideKeyboardOnTapped() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        viewController?.view.addGestureRecognizer(tap)
    }

    private func moveToNewActiveView() {
        guard let viewController = viewController,
              let activeView = activeView,
              let window = viewController.view.window else { return }

        let viewBounds = activeView.convert(activeView.bounds, to: window)
        let viewBottom = viewBounds.midY
        let keyboardTop = window.frame.height - keyboardHeight
        let newOffset = keyboardTop - viewBottom - 120
        let newY = viewController.view.transform.ty + newOffset

        UIView.animate(withDuration: 0.3) {
            viewController.view.transform = CGAffineTransform(translationX: 0, y: newY)
            self.currentOffset = newOffset
        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        keyboardHeight = keyboardFrame.height
        currentOffset = 0

        if activeView != nil {
            moveToNewActiveView()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let viewController = viewController else { return }

        keyboardHeight = 0
        currentOffset = 0

        UIView.animate(withDuration: 0.25) {
            viewController.view.transform = .identity
        }
    }

    @objc private func dismissKeyboard() {
        viewController?.view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
