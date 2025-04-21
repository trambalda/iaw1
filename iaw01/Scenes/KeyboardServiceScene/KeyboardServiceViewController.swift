import UIKit

final class KeyboardServiceViewController: UIViewController {

    private var keyboardService: KeyboardServiceProtocol? = KeyboardService()

    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()

    private let nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        return textField
    }()

    private let emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        return textField
    }()

    private let passwordTextField: StringTextField = {
        let textField = StringTextField(with: .passwordStyle)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        keyboardService?.isEnabled = true

        setupLayout()
        setupTextFieldResponders()
        setupConstraints()
    }

    private func setupLayout() {
        textFieldsStack.addArrangedSubview(nameTextField)
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        view.addSubview(textFieldsStack)
    }

    private func setupTextFieldResponders() {
        nameTextField.textFieldShouldReturn = {
            self.emailTextField.becomeTextFieldFirstResponder()
        }

        emailTextField.textFieldShouldReturn = {
            self.passwordTextField.becomeTextFieldFirstResponder()
        }

        passwordTextField.textFieldShouldReturn = {
            self.passwordTextField.resignTextFieldFirstResponder()
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
        ])
    }
}
