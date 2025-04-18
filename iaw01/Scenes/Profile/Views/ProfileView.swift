import UIKit

class ProfileView: UIView {
    
    var onSafeButtonTapped: (() -> Void)?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .avatar
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var selectAvatarButton: SelectPhotoButton = {
        let button = SelectPhotoButton()
        return button
    }()
    
    private lazy var fullNameView: FullNameView = {
        let view = FullNameView()
        view.textFieldDelegate = self
        return view
    }()
    
    private lazy var phoneNumberView: InputView = {
        let view = InputView()
        return view
    }()
    
    private lazy var apiKeyView: ApiKeyView = {
        let view = ApiKeyView()
        view.textFieldDelegate = self
        return view
    }()
    
    private lazy var saveButton: CornersButton = {
        let button = CornersButton(style: .saveDarkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func saveButtonDidTapped() {
        onSafeButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupObservers()
        print("Original size:", avatarView.bounds.size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }
    
    private func setupLayout() {
        addSubview(mainStackView)
        let avatarHStack = UIStackView()
        avatarHStack.alignment = .center
        avatarHStack.addArrangedSubview(avatarView)
        mainStackView.addArrangedSubview(avatarHStack)
        let buttonVStack = UIStackView()
        buttonVStack.axis = .vertical
        buttonVStack.alignment = .center
        buttonVStack.addArrangedSubview(selectAvatarButton)
        mainStackView.addArrangedSubview(buttonVStack)
        mainStackView.addArrangedSubview(fullNameView)
        mainStackView.addArrangedSubview(phoneNumberView)
        mainStackView.addArrangedSubview(apiKeyView)
        mainStackView.addArrangedSubview(saveButton)
        
        mainStackView.setCustomSpacing(17, after: avatarView)
        mainStackView.setCustomSpacing(16, after: selectAvatarButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
           
            fullNameView.heightAnchor.constraint(equalToConstant: 80),
            phoneNumberView.heightAnchor.constraint(equalToConstant: 80),
            apiKeyView.heightAnchor.constraint(equalToConstant: 80),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
    }
}

extension ProfileView {
    private func setupObservers() {
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow),
            willHideSelector: #selector(keyboardWillHide)
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.avatarView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.selectAvatarButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.avatarView.transform = .identity
            self.selectAvatarButton.transform = .identity
        }
    }
}

extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
