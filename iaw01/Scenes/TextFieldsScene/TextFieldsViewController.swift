import UIKit

final class TextFieldsViewController: UIViewController {
    
    private lazy var createPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField(with: .createPasswordStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textFieldShouldReturn = {
            self.passwordTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField(with: .passwordStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textFieldShouldReturn = {
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
        view.addSubview(createPasswordTextField)
        view.addSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            createPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createPasswordTextField.heightAnchor.constraint(equalToConstant: 80),

            passwordTextField.topAnchor.constraint(equalTo: createPasswordTextField.bottomAnchor, constant: 26),
            passwordTextField.leadingAnchor.constraint(equalTo: createPasswordTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: createPasswordTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: createPasswordTextField.heightAnchor)
        ])
    }
}

