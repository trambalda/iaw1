import UIKit

final class TextFieldsViewController: UIViewController {
    
    private lazy var emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textFieldShouldReturn = {
            self.nameTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var nameTextField: StringTextField = {
        let textField = StringTextField(with: .createPasswordStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textFieldShouldReturn = {
            print("Final Email:\(self.emailTextField.text ?? "")")
            print("Final Name:\(textField.text ?? "")")
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
        view.addSubview(emailTextField)
        view.addSubview(nameTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 80),

            nameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
}
