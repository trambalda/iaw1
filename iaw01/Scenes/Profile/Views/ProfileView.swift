import UIKit

class ProfileView: UIView {
    
    private var fullNameViewTopConstraint: NSLayoutConstraint!
    
    private var avatarImageViewTopConstraint: NSLayoutConstraint!
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var avatarView: AvatarView = {
        let image = AvatarView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var selectAvatarButton: SelectPhotoButton = {
        let button = SelectPhotoButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var fullNameView: FullNameView = {
        let view = FullNameView()
        view.textFieldDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneNumberView: PhoneNumberView = {
        let view = PhoneNumberView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var apiKeyView: ApiKeyView = {
        let view = ApiKeyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var apiKeyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var apiKeyTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupObservers()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }
    
    private func setupLayout() {
        addSubview(avatarView)
        addSubview(selectAvatarButton)
        addSubview(fullNameView)
        addSubview(phoneNumberView)
        addSubview(apiKeyView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            avatarView.heightAnchor.constraint(equalToConstant: 150),
            avatarView.widthAnchor.constraint(equalToConstant: 150),
            
            selectAvatarButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 17),
            selectAvatarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 125),
            
            fullNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            fullNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            phoneNumberView.topAnchor.constraint(equalTo: fullNameView.bottomAnchor, constant: 15),
            phoneNumberView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            phoneNumberView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            apiKeyView.topAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: 15),
            apiKeyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            apiKeyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
        ])
        fullNameViewTopConstraint = fullNameView.topAnchor.constraint(equalTo: selectAvatarButton.bottomAnchor, constant: 16)
        fullNameViewTopConstraint.isActive = true
        
        avatarImageViewTopConstraint = avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        avatarImageViewTopConstraint.isActive = true
    }
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        endEditing(true)
    }
    
    private func keyBoardWillHideConfig() {
        
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
            self.selectAvatarButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        } completion: { _ in
            self.selectAvatarButton.isHidden = true
        }
        
        avatarImageViewTopConstraint?.isActive = false
        avatarImageViewTopConstraint = avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5)
        avatarImageViewTopConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.avatarView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }
        
        fullNameViewTopConstraint?.isActive = false
        fullNameViewTopConstraint = fullNameView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 1)
        fullNameViewTopConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeInOut) {
            self.selectAvatarButton.transform = .identity
        }
        animator.addCompletion { _ in
            self.selectAvatarButton.isHidden = false
        }
        animator.startAnimation()
        
        avatarImageViewTopConstraint?.isActive = false
        avatarImageViewTopConstraint = avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        avatarImageViewTopConstraint?.isActive = true
        
        fullNameViewTopConstraint?.isActive = false
        fullNameViewTopConstraint = fullNameView.topAnchor.constraint(equalTo: selectAvatarButton.bottomAnchor, constant: 16)
        fullNameViewTopConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.avatarView.transform = .identity
        }
    }
}

extension ProfileView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
