import UIKit

final class TextFieldsViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
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
            self.nameTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.textFieldShouldReturn = {
            self.passwordTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var passwordTextField: StringTextField = {
        let textField = StringTextField(with: .passwordStyle)
        textField.textFieldShouldReturn = {
            self.createPasswordTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var createPasswordTextField: StringTextField = {
        let textField = StringTextField(with: .createPasswordStyle)
        textField.textFieldShouldReturn = {
            self.phoneTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var phoneTextField: PhoneTextField = {
        let textField = PhoneTextField(parent: self.view)
        textField.phoneNumber = .default
        textField.textFieldShouldReturn = {
            print("Phone Number: \(textField.phoneNumber.fullNumber)")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(textFieldsStack)
        textFieldsStack.addArrangedSubview(linkButton)
        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(nameTextField)
        textFieldsStack.addArrangedSubview(passwordTextField)
        textFieldsStack.addArrangedSubview(createPasswordTextField)
        textFieldsStack.addArrangedSubview(phoneTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textFieldsStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textFieldsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textFieldsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            textFieldsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
        ])
    }
    
    @objc func keyboardChange(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardViewFrame = view.convert(keyboardValue.cgRectValue, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        } else {
            scrollView.contentInset.bottom = keyboardViewFrame.height
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardViewFrame.height
        }
    }
}

