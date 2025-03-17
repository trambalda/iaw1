import UIKit

final class TextFieldsViewController: UIViewController {
    
    private let emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .light100)
        
        setupScreenLayout()
        setupScreenConstraints()
        setupTextFieldActions()
    }
    
    private func setupScreenLayout() {
        view.addSubview(emailTextField)
        view.addSubview(nameTextField)
    }
    
    private func setupScreenConstraints() {
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
    
    private func setupTextFieldActions() {
        emailTextField.didPressReturn = { [weak self] in
            self?.nameTextField.textFieldControl.becomeFirstResponder()
        }
        
        nameTextField.didPressReturn = { [weak self] in
            guard let self = self else { return }
            print("Final Email:\(self.emailTextField.textFieldControl.text ?? "")")
            print("Final Name:\(self.nameTextField.textFieldControl.text ?? "")")
            self.nameTextField.textFieldControl.resignFirstResponder()
        }
    }
}

