import UIKit

final class AuthorizationSignupView: UIStackView {
    
    var viewChanged: ((AuthorizationModel) -> Void)?
    
    var model: AuthorizationModel {
        get {
            AuthorizationModel(
                email: nil,
                password: createPasswordTextField.text,
                name: nameTextField.text,
                phone: phoneNumberTextField.phoneNumber.fullNumber
            )
        }
        set {
            nameTextField.text = newValue.name
            phoneNumberTextField.phoneNumber = PhoneNumber(fullString: newValue.phone ?? "") ?? .default
            createPasswordTextField.text = newValue.password
        }
    }
    
    private let socialButtons = AuthorizationSocialButtonsView()
    
    private lazy var nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.textFieldShouldReturn = { [weak self] in
            self?.phoneNumberTextField.becomeTextFieldFirstResponder()
        }
        textField.editingChanged = { [weak self] _ in
            guard let self else { return }
            viewChanged?(self.model)
        }
        return textField
    }()
    
    private lazy var phoneNumberTextField: PhoneTextField = {
        let textField = PhoneTextField(parent: self)
        textField.textFieldShouldReturn = { [weak self] in
            self?.createPasswordTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var createPasswordTextField: StringTextField = {
        let textField = StringTextField(with: .createPasswordStyle)
        textField.textFieldShouldReturn = { [weak self] in
            self?.createPasswordTextField.resignTextFieldFirstResponder()
        }
        textField.editingChanged = { [weak self] _ in
            guard let self else { return }
            viewChanged?(self.model)
        }
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configure() {
        axis = .vertical
        setupLayout()
        viewChanged?(model)
    }
    
    private func setupLayout() {
        addArrangedSubview(nameTextField)
        addArrangedSubview(phoneNumberTextField)
        addArrangedSubview(createPasswordTextField)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: nameTextField)
        setCustomSpacing(26, after: phoneNumberTextField)
        setCustomSpacing(26, after: createPasswordTextField)
    }
}
