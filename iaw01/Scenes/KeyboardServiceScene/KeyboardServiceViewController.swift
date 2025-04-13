
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        keyboardService = KeyboardService(viewController: self)

        textfieldDelegate()
        setupLayout()
        setupConstraints()
    }

    private func textfieldDelegate() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(textFieldDidBeginEditingNotification(_:)),
                name: UITextField.textDidBeginEditingNotification,
                object: nil
            )
    }

    private func setupLayout() {
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        textFieldsStack.addArrangedSubview(nameTextField)
        view.addSubview(textFieldsStack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        ])
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension KeyboardServiceViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardService?.adjustViewForKeyboard(textField)
    }

    @objc private func textFieldDidBeginEditingNotification(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            keyboardService?.adjustViewForKeyboard(textField)
        }
    }


}
