import UIKit

class ProfileView: UIView {
    
    var onSafeButtonTapped: (() -> Void)?
    
    private var avatarTopConstraint: NSLayoutConstraint!
    
    private var avatarHeightConstraint: NSLayoutConstraint!
    
    private var selectButtonTopConstraint: NSLayoutConstraint!
    
    private var selectButtonHeightConstraint: NSLayoutConstraint!
    
    private lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
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
    
    private lazy var phoneNumberView: ProfilePhoneNumberInputView = {
        let view = ProfilePhoneNumberInputView()
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
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 150),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 150),
            
            selectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: Constants.isSE ? 6 : 16),
            mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -RootTabBarController.height)
        ])
        avatarTopConstraint = avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 64)
        avatarTopConstraint.isActive = true
        
        avatarHeightConstraint = avatarView.heightAnchor.constraint(equalToConstant: 150)
        avatarHeightConstraint.isActive = true
        
        selectButtonTopConstraint = selectButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.isSE ? 7 : 17)
        selectButtonTopConstraint.isActive = true
        
        selectButtonHeightConstraint = selectButton.heightAnchor.constraint(equalToConstant: 48)
        selectButtonHeightConstraint.isActive = true
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
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut]) {
            self.avatarHeightConstraint.constant = Constants.isSE ? 80 : 100
            self.avatarTopConstraint.constant = 59
            self.selectButtonTopConstraint.constant = 7
            self.selectButtonHeightConstraint.constant = 35
            self.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut]) {
            self.avatarHeightConstraint.constant = Constants.isSE ? 100 : 150
            self.avatarTopConstraint.constant = 64
            self.selectButtonTopConstraint.constant = 17
            self.selectButtonHeightConstraint.constant = 48
            self.layoutIfNeeded()
        }
    }
}

extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
