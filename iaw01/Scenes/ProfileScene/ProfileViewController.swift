import UIKit

final class ProfileViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let avatarView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .avatar
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let apiKeyTextField: StringTextField = {
        let textField = StringTextField(
            with: StringTextFieldStyle(
                title: "API Key",
                placeholder: "Enter your API",
                behavior: .string))
        textField.textFieldShouldReturn = {
            textField.resignTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(.selectAvatarButton, for: .normal)
        button.addTarget(self, action: #selector(selectPhotoButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fullNameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.textFieldShouldReturn = {
            self.phoneNumberTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var phoneNumberTextField: PhoneTextField = {
        let textField = PhoneTextField(parent: view.self)
        textField.textFieldShouldReturn = {
            self.apiKeyTextField.becomeTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var saveButton: CornersButton = {
        let button = CornersButton(style: .saveDarkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        return button
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
    
    @objc private func selectPhotoButtonDidTapped() {
        print("Select photo button tapped")
    }
    
    @objc private func saveButtonDidTapped() {
        print("Save button tapped")
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(avatarView)
        scrollView.addSubview(selectPhotoButton)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(fullNameTextField)
        mainStackView.addArrangedSubview(phoneNumberTextField)
        mainStackView.addArrangedSubview(apiKeyTextField)
        scrollView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            avatarView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            avatarView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 150),
            
            selectPhotoButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.isSE ? 5 : 17),
            selectPhotoButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            selectPhotoButton.widthAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 140),
            
            mainStackView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: Constants.isSE ? 5 : 16),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            mainStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: Constants.isSE ? -29 : -83),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -42),
            
            saveButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            saveButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
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
