import UIKit

final class AuthorizationLoginView: UIStackView {
    
    var viewChanged: ((AuthorizationModel?) -> Void)?
    
    private let socialButtons = AuthorizationSocialButtonsView()
    private let emailTextField = StringTextField(with: .emailStyle)
    private let passwordTextField = StringTextField(with: .passwordStyle)
    private let forgotPasswordButton = LinkButton(style: .forgotPassword)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configure() {
        axis = .vertical
        setupLayout()
        setupReturnActions()
        setupTextObservers()
        viewChanged?(model)
    }
    
    private func setupLayout() {
        addArrangedSubview(emailTextField)
        addArrangedSubview(passwordTextField)
        addArrangedSubview(stackView)
        stackView.addArrangedSubview(forgotPasswordButton)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: emailTextField)
        setCustomSpacing(15, after: passwordTextField)
        setCustomSpacing(38, after: stackView)
    }
    
    private func setupReturnActions() {
        emailTextField.textFieldShouldReturn = { [weak self] in
            self?.passwordTextField.becomeTextFieldFirstResponder()
        }
        passwordTextField.textFieldShouldReturn = { [weak self] in
            self?.passwordTextField.resignTextFieldFirstResponder()
        }
    }
    
    private func setupTextObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func textFieldDidChange(notification: Notification) {
        viewChanged?(model)
    }
}

extension AuthorizationLoginView {
    var model: AuthorizationModel? {
        get {
            guard
                let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty
            else {
                return nil
            }
            return AuthorizationModel(email: email, password: password, name: nil, phone: nil)
        }
        set {
            emailTextField.text = newValue?.email
            passwordTextField.text = newValue?.password
        }
    }
}
