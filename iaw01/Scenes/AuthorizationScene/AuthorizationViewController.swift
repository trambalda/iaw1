import UIKit

final class AuthorizationViewController: UIViewController {
    
    private var authorizationService: AuthorizationNetworkServiceProtocol = AuthorizationNetworkService(networkService: NetworkService())
    
    private lazy var authorizationView: AuthorizationView = {
        let view = AuthorizationView(frame: UIScreen.main.bounds)
        view.model = AuthorizationModel.empty
        
        view.onLoginTap = { [weak self] model in
            Task {
                do {
                    guard
                        let self = self,
                        let email = model.email,
                        let password = model.password
                    else {
                        return
                    }
                    let user = try await self.authorizationService.login(email: email, password: password)
                    print("успешно, ответ от сервера: \(user)")
                    DispatchQueue.main.async {
                        self.showAlert(title: "Успешно", message: user)
                    }
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Ошибка", message: "Неверный логин или пароль")
                    }
                }
            }
        }
        
        view.onSignupTap = { [weak self] model in
            if let errorValidate = Validatior.validate(
                name: model.name,
                phone: model.phone,
                email: model.email ?? "",
                password: model.password ?? "",
                context: .register
            ) {
                self?.showAlert(title: "Ошибка", message: errorValidate)
                return
            }
            
            Task {
                do {
                    guard
                        let self = self,
                        let name = model.name,
                        let phone = model.phone,
                        let password = model.password,
                        let email = model.email
                    else {
                        return
                    }
                    let user = try await self.authorizationService.register(name: name, phone: phone, email: email, password: password)
                    print("успешно, ответ от сервера: \(user)")
                    DispatchQueue.main.async {
                        self.showAlert(title: "Выполнен вход", message: "Вход в приложение")
                    }
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Ошибка", message: "Не удалось создать пользователя")
                    }
                }
            }
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
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        let keyboardHeight = keyboardFrame.height
        let extraOffset: CGFloat = 16
        let staticOffset: CGFloat = 55
        let shift = -keyboardHeight - extraOffset + staticOffset
        
        authorizationView.bottomButtonBottomConstraint.constant = shift
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
        authorizationView.scrollView.contentInset.bottom = shift + 64
        authorizationView.scrollView.verticalScrollIndicatorInsets.bottom = shift
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        authorizationView.bottomButtonBottomConstraint.constant = -55
        authorizationView.scrollView.contentInset.bottom = 0
        authorizationView.scrollView.verticalScrollIndicatorInsets.bottom = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
