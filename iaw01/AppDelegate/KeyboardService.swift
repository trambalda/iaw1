
import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    func adjustView(for responder: UIResponder?)
}

final class KeyboardService: KeyboardServiceProtocol {

    private weak var viewController: UIViewController?
    private var activeResponder: UIResponder?
    private var keyboardHeight: CGFloat = 0

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

        //    func adjustView(for responder: UIResponder?) {
        //        activeResponder = responder
        //
        //        guard let responder = responder as? UIView,
        //              let viewController = viewController else { return }
        //
        //        let responderFrame = responder.convert(responder.bounds, to: viewController.view)
        //        let bottomSpace = viewController.view.frame.height - responderFrame.maxY
        //
        //        if bottomSpace < keyboardHeight {
        //            animateView(bottomSpace)
        //        } else {
        //            viewController.view.frame.origin.y = 0
        //        }
        //
        //        viewController.view.layoutIfNeeded()
        //    }

    func adjustView(for responder: UIResponder?) {
        activeResponder = responder
        updateViewPosition()
    }

    private func updateViewPosition() {
        guard let responder = activeResponder as? UIView,
                     let vc = viewController
               else { return }

               // Обновляем layout, чтобы фреймы были актуальны
               vc.view.layoutIfNeeded()

               // Получаем фрейм активного текстового поля в координатах vc.view
               let responderFrame = responder.convert(responder.bounds, to: vc.view)

               // Берём нижний safe area inset (он учитывает вырезы и прочие особенности)
               let safeAreaBottom = vc.view.safeAreaInsets.bottom
               // Вычисляем видимую высоту: от начала вью до верхней границы клавиатуры
               let visibleHeight = vc.view.bounds.height - keyboardHeight - safeAreaBottom
               // Дополнительное пространство (запас, можно настроить)
               let padding: CGFloat = 0

               // Если нижняя граница текстового поля вместе с запасом выходит за пределы видимой области,
               // вычисляем смещение, иначе view не сдвигается.
               if responderFrame.maxY + padding > visibleHeight {
                   let offset = (responderFrame.maxY + padding) - visibleHeight
                   UIView.animate(withDuration: 0.3) {
                       vc.view.frame.origin.y = -offset
                   }
               } else {
                   // Если view уже сдвинуто, возвращаем её в исходное положение
                   if vc.view.frame.origin.y != 0 {
                       UIView.animate(withDuration: 0.3) {
                           vc.view.frame.origin.y = 0
                       }
                   }
               }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder
                .keyboardFrameEndUserInfoKey] as? CGRect else { return }

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
