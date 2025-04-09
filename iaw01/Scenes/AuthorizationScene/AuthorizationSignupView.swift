import UIKit

class AuthorizationSignupView: UIStackView {
    
    private let nameTextField = StringTextField(with: .nameStyle)
    private let phoneNumberTextField = StringTextField(with: .phoneNumberStyle)
    private let createPasswordTextField = StringTextField(with: .createPasswordStyle)
    private let socialButtons = AuthorizationSocialButtonsView()
    
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
        addArrangedSubview(nameTextField)
        addArrangedSubview(phoneNumberTextField)
        addArrangedSubview(createPasswordTextField)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: nameTextField)
        setCustomSpacing(26, after: phoneNumberTextField)
        setCustomSpacing(37, after: createPasswordTextField)
    }
}

extension StringTextFieldStyle {
    static let phoneNumberStyle = StringTextFieldStyle(
        title: "Phone Number",
        placeholder: "+1  |  000 000 0000",
        behavior: .string)
}
