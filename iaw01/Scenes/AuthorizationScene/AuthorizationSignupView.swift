import UIKit

final class AuthorizationSignupView: UIStackView {
    
    var viewChanged: ((AuthorizationModel?) -> Void)?
    
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
        addArrangedSubview(nameTextField)
        addArrangedSubview(phoneNumberTextField)
        addArrangedSubview(createPasswordTextField)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: nameTextField)
        setCustomSpacing(26, after: phoneNumberTextField)
        setCustomSpacing(37, after: createPasswordTextField)
    }
    
    private func setupReturnActions() {
        nameTextField.textFieldShouldReturn = { [weak self] in
            self?.phoneNumberTextField.becomeTextFieldFirstResponder()
        }
        phoneNumberTextField.textFieldShouldReturn = { [weak self] in
            self?.createPasswordTextField.becomeTextFieldFirstResponder()
        }
        createPasswordTextField.textFieldShouldReturn = { [weak self] in
            self?.createPasswordTextField.resignTextFieldFirstResponder()
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

extension StringTextFieldStyle {
    static let phoneNumberStyle = StringTextFieldStyle(
        title: "Phone Number",
        placeholder: "+1  |  000 000 0000",
        behavior: .string)
}

extension AuthorizationSignupView {
    var model: AuthorizationModel? {
        get {
            guard
                let name = nameTextField.text, !name.isEmpty,
                let phone = phoneNumberTextField.text, !phone.isEmpty,
                let password = createPasswordTextField.text, !password.isEmpty
            else {
                return nil
            }
            return AuthorizationModel(email: nil, password: password, name: name, phone: phone)
        }
        set {
            nameTextField.text = newValue?.name
            phoneNumberTextField.text = newValue?.phone
            createPasswordTextField.text = newValue?.password
        }
    }
}
