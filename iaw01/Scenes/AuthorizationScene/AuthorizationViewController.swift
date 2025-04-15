import UIKit

final class AuthorizationViewController: UIViewController {
    
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView(frame: UIScreen.main.bounds)
        
        view.onLoginTap = { model in
            print("Login нажат и выводит \(model)")
        }
        
        view.onSignupTap = { model in
            print("Sign up нажат и выводит \(model) ")
        }
        
        return view
    }()
    
    override func loadView() {
        view = authorizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDismissKeyboardGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow),
            willHideSelector: #selector(keyboardWillHide)
        )
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        let keyboardHeight = keyboardFrame.height
        let buttonHeight = self.authorizationView.bottomButton.frame.height
        let translationY = max(0, keyboardHeight - buttonHeight - 12)
        
        authorizationView.scrollView.contentInset.bottom = keyboardHeight + 64
        authorizationView.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.authorizationView.bottomButton.transform = CGAffineTransform(translationX: 0, y: -translationY)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        authorizationView.scrollView.contentInset.bottom = 0
        authorizationView.scrollView.verticalScrollIndicatorInsets.bottom = 0
        
        UIView.animate(withDuration: 0.3) {
            self.authorizationView.bottomButton.transform = .identity
        }
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
