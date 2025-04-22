import UIKit

class ProfileView: UIView {
    
    var onSafeButtonTapped: (() -> Void)?
    
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
    
    private lazy var fullNameView: StringTextField = {
        let view = StringTextField(with: .nameStyle)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneNumberView: ProfilePhoneNumberInputView = {
        let view = ProfilePhoneNumberInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var apiKeyView: StringTextField = {
        let view = StringTextField(with: .nameStyle)
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
        addSubview(saveButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 150),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.isSE ? 100 : 150),
            
            selectButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.isSE ? 7 : 17),
            selectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 48),
            
            mainStackView.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: Constants.isSE ? 6 : 16),
            mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -RootTabBarController.height)
        ])
    }
}
