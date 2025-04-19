import UIKit

class ProfileView: UIView {
    
    var onSafeButtonTapped: (() -> Void)?
    
    private lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.image = .avatar
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var selectButton: SelectPhotoButton = {
        let button = SelectPhotoButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var fullNameView: FullNameView = {
        let view = FullNameView()
        view.textFieldDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneNumberView: InputView = {
        let view = InputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var apiKeyView: ApiKeyView = {
        let view = ApiKeyView()
        view.textFieldDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }
    
    private func setupLayout() {
        addSubview(avatarView)
        addSubview(selectButton)
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(fullNameView)
        mainStackView.addArrangedSubview(phoneNumberView)
        mainStackView.addArrangedSubview(apiKeyView)
        mainStackView.addArrangedSubview(saveButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 150),
            avatarView.widthAnchor.constraint(equalToConstant: 150),
            
            selectButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 17),
            selectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 48),
            
            mainStackView.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
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
            self.avatarView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.selectButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.avatarView.transform = .identity
            self.selectButton.transform = .identity
        }
    }
}

extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
