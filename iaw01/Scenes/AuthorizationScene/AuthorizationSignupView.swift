import UIKit

class AuthorizationSignupView: UIStackView {
    
    var onFieldsChange: ((Bool) -> Void)?
    
    var signupTextFields: [StringTextField] {
        return [nameTextField, phoneNumberTextField, createPasswordTextField]
    }
    
    private let nameTextField = StringTextField(with: .nameStyle)
    private let phoneNumberTextField = StringTextField(with: .phoneNumberStyle)
    private let createPasswordTextField = StringTextField(with: .createPasswordStyle, isLastField: true)
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
        observeTextFields()
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
    
    private func observeTextFields() {
        nameTextField.onTextChanged = { [weak self] _ in self?.checkFormFilled() }
        phoneNumberTextField.onTextChanged = { [weak self] _ in self?.checkFormFilled() }
        createPasswordTextField.onTextChanged = { [weak self] _ in self?.checkFormFilled() }
    }
    
    private func checkFormFilled() {
        let allFilled = !(nameTextField.text ?? "").isEmpty &&
                        !(phoneNumberTextField.text ?? "").isEmpty &&
                        !(createPasswordTextField.text ?? "").isEmpty
        onFieldsChange?(allFilled)
    }
}

extension StringTextFieldStyle {
    static let phoneNumberStyle = StringTextFieldStyle(
        title: "Phone Number",
        placeholder: "+1  |  000 000 0000",
        behavior: .string)
}

extension AuthorizationSignupView {
    func getModel() -> AuthorizationModel {
        return AuthorizationModel(
            email: nil,
            password: createPasswordTextField.text ?? "",
            name: nameTextField.text ?? "",
            phone: phoneNumberTextField.text ?? ""
        )
    }
}
