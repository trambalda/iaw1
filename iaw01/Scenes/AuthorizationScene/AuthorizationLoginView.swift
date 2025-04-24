import UIKit

final class AuthorizationLoginView: UIStackView {
    
    var viewChanged: ((AuthorizationModel?) -> Void)?
    
    private let socialButtons = AuthorizationSocialButtonsView()
    private let forgotPasswordButton = LinkButton(style: .forgotPassword)
    
    private lazy var emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        textField.textFieldShouldReturn = { [weak self] in
            self?.passwordTextField.becomeTextFieldFirstResponder()
        }
        textField.editingChanged = { [weak self] _ in
            self?.viewChanged?(self?.model)
        }
        return textField
    }()
    
    private lazy var passwordTextField: StringTextField = {
        let textField = StringTextField(with: .passwordStyle)
        textField.textFieldShouldReturn = { [weak self] in
            self?.passwordTextField.resignTextFieldFirstResponder()
        }
        textField.editingChanged = { [weak self] _ in
            self?.viewChanged?(self?.model)
        }
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    var model: AuthorizationModel {
        get {
            AuthorizationModel(
                email: emailTextField.text,
                password: passwordTextField.text,
                name: nil,
                phone: nil
            )
        }
        set {
            emailTextField.text = newValue.email
            passwordTextField.text = newValue.password
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        setupLayout()
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
        setCustomSpacing(30, after: stackView)
    }
}
