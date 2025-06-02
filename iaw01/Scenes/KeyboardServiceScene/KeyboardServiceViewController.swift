import UIKit

final class KeyboardServiceViewController: UIViewController {

    var keyboardService: KeyboardServiceProtocol?

    private let textFieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()

    private let emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        return textField
    }()

    private let nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        return textField
    }()

    private let passwordTextField: StringTextField = {
        let textField = StringTextField(with: .passwordStyle)
        return textField
    }()

    private let createPasswordTextField: StringTextField = {
        let textField = StringTextField(with: .createPasswordStyle)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        keyboardService?.isEnabled = true

        setupLayout()
        setupResponders()
        setupConstraints()
    }

    private func setupLayout() {
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(nameTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        textFieldsStack.addArrangedSubview(createPasswordTextField)
        
        view.addSubview(textFieldsStack)
    }

    private func setupResponders() {
        emailTextField.textFieldShouldReturn = {
            self.nameTextField.becomeTextFieldFirstResponder()
        }

        nameTextField.textFieldShouldReturn = {
            self.passwordTextField.becomeTextFieldFirstResponder()
        }

        passwordTextField.textFieldShouldReturn = {
            self.createPasswordTextField.becomeTextFieldFirstResponder()
        }

        createPasswordTextField.textFieldShouldReturn = { [weak self] in
            self?.createPasswordTextField.resignTextFieldFirstResponder()
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                textFieldsStack.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -RootTabBarController.height - 20
                ),
            ]
        )
    }
}
