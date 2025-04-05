
import UIKit

final class KeyboardService {

    private weak var viewController: UIViewController?
    private weak var scrollView: UIScrollView?

    init(viewController: UIViewController? = nil, scrollView: UIScrollView? = nil) {
        self.viewController = viewController
        self.scrollView = scrollView
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

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let scrollView = scrollView else { return }

        let keyboardHeight = keyboardFrame.height
        let contentInserts = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInserts
        scrollView.scrollIndicatorInsets = contentInserts

    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let scrollView = scrollView else { return }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
