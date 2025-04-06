
import UIKit

final class KeyboardServiceViewController: UIViewController {

    private var keyboardService: KeyboardServiceProtocol?

    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.rightViewMode = .whileEditing
        textField.backgroundColor = .light60
        textField.layer.cornerRadius = 25
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.rightViewMode = .whileEditing
        textField.backgroundColor = .light60
        textField.layer.cornerRadius = 25
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100

        keyboardService = KeyboardService(viewController: self)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        view.addSubview(textFieldsStack)
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension KeyboardServiceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardService?.adjustView(for: textField)
        
    }
}
