
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

    private lazy var emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        return textField
    }()

    private lazy var nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        return textField
    }()

    private lazy var passwordTextField: StringTextField = {
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
            .addObserver(self, selector: #selector(textFieldDidBeginEditingNotification(_:)),
                         name: UITextField.textDidBeginEditingNotification,
                         object: nil)
    }

    private func setupLayout() {
        view.addSubview(textFieldsStack)
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        textFieldsStack.addArrangedSubview(nameTextField)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
