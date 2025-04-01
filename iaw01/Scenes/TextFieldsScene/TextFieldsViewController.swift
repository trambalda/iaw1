import UIKit

final class TextFieldsViewController: UIViewController {
    
    private let linkButton: LinkButton = {
        let linkButton = LinkButton(style: .forgotPassword)
        linkButton.onTap = {
            print("linkButton tapped")
        }
        return linkButton
    }()
    
    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        textField.textFieldShouldReturn = {
            self.phoneTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
//    
//    private lazy var nameTextField: StringTextField = {
//        let textField = StringTextField(with: .nameStyle)
//        textField.textFieldShouldReturn = {
//            self.passwordTextField.becomeTextFieldFirstResponder()
//        }
//        return textField
//    }()
//    
//    private lazy var passwordTextField: StringTextField = {
//        let textField = StringTextField(with: .passwordStyle)
//        textField.textFieldShouldReturn = {
//            self.createPasswordTextField.becomeTextFieldFirstResponder()
//        }
//        return textField
//    }()
//    
//    private lazy var createPasswordTextField: StringTextField = {
//        let textField = StringTextField(with: .createPasswordStyle)
//        textField.textFieldShouldReturn = {
//            self.phoneTextField.becomeTextFieldFirstResponder()
//        }
//        return textField
//    }()
    
    private lazy var phoneTextField: PhoneTextField = {
        let textField = PhoneTextField(with: .phoneNumberStyle, superView: self.view)
        textField.textFieldShouldReturn = {
            print("Phone Number: \(textField.getFullPhoneNumber() ?? "")")
            textField.resignTextFieldFirstResponder()
        }
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        view.addSubview(textFieldsStack)
        textFieldsStack.addArrangedSubview(linkButton)
        textFieldsStack.addArrangedSubview(emailTextField)
        //textFieldsStack.addArrangedSubview(nameTextField)
        //textFieldsStack.addArrangedSubview(passwordTextField)
        //textFieldsStack.addArrangedSubview(createPasswordTextField)
        textFieldsStack.addArrangedSubview(phoneTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

