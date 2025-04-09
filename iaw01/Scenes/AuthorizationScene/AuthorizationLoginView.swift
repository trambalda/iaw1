import UIKit

class AuthorizationLoginView: UIStackView {
    
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
    
    private func configure() {
        setupStackView()
        setupLayout()
    }
    
    private func setupStackView() {
        axis = .vertical
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
