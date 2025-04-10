import UIKit

class AuthorizationViewController: UIViewController {
    
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = authorizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow),
            willHideSelector: #selector(keyboardWillHide)
        )
        
        authorizationView.onLoginTap = { model in
            print("Login нажат и выводит \(model)")
        }
        
        authorizationView.onSignupTap = { model in
            print("Sign up нажат и выводит \(model) ")
        }
        
        setupDismissKeyboardGesture()
        configureTextFieldsReturnKey()
        configureSignupTextFieldsReturnKey()
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
    
    private func configureTextFieldsReturnKey() {
        let textFields = authorizationView.loginView.loginTextFields
        
        for (index, field) in textFields.enumerated() {
            field.textFieldShouldReturn = { [weak self] in
                guard self != nil else { return }
                if index < textFields.count - 1 {
                    textFields[index + 1].becomeTextFieldFirstResponder()
                } else {
                    field.resignTextFieldFirstResponder()
                }
            }
        }
    }
    
    private func configureSignupTextFieldsReturnKey() {
        let textFields = authorizationView.signupView.signupTextFields
        
        for (index, field) in textFields.enumerated() {
            field.textFieldShouldReturn = { [weak self] in
                guard self != nil else { return }
                if index < textFields.count - 1 {
                    textFields[index + 1].becomeTextFieldFirstResponder()
                } else {
                    field.resignTextFieldFirstResponder()
                }
            }
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
