import UIKit

class AuthorizationLoginView: UIStackView {
    
    var loginTextFields: [StringTextField] {
        return [emailTextField, passwordTextField]
    }
    
    private let socialButtons = AuthorizationSocialButtonsView()
    private let emailTextField = StringTextField(with: .emailStyle)
    private let passwordTextField = StringTextField(with: .passwordStyle, isLastField: true)
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
    
    private func configure() {
        axis = .vertical
        setupLayout()
    }

    private func setupLayout() {
        addArrangedSubview(emailTextField)
        addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(forgotPasswordButton)
        addArrangedSubview(stackView)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: emailTextField)
        setCustomSpacing(15, after: passwordTextField)
        setCustomSpacing(38, after: stackView)
    }
}

extension AuthorizationLoginView {
    func getModel() -> AuthorizationModel {
        return AuthorizationModel(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            name: nil,
            phone: nil
        )
    }
}
