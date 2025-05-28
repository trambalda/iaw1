import UIKit
import PhotosUI

protocol ProfileViewDelegate: AnyObject {
    func presentImagePicker(_ picker: PHPickerViewController)
}

final class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
    var avatar: UIImage {
        get { avatarView.image ?? .avatar }
        set { avatarView.image = newValue }
    }
    
    var fullName: String? {
        get { fullNameTextField.text }
        set { fullNameTextField.text = newValue }
    }
    
    var phoneNumber: PhoneNumber {
        get { phoneNumberTextField.phoneNumber }
        set { phoneNumberTextField.phoneNumber = newValue }
    }
    
    var onSaveButtonTapped: (() -> Void)?

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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = .avatar
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.clear.cgColor
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton()
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
        let textField = PhoneTextField(parent: self)
        textField.phoneNumber = .default
        textField.textFieldShouldReturn = {
            textField.resignTextFieldFirstResponder()
        }
        return textField
    }()
    
    private lazy var saveButton: CornersButton = {
        let button = CornersButton(style: .saveDarkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = avatarView.bounds.width / 3
    }
    
    func updateAvatar(image: UIImage) {
        avatarView.image = image
    }
    
    @objc private func selectPhotoButtonDidTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        
        delegate?.presentImagePicker(picker)
        
    }
    
    @objc private func saveButtonDidTapped() {
        onSaveButtonTapped?()
    }
    
    private func setupLayout() {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(vStack)
        vStack.addArrangedSubview(avatarView)
        vStack.addArrangedSubview(selectPhotoButton)
        mainStackView.addArrangedSubview(fullNameTextField)
        mainStackView.addArrangedSubview(phoneNumberTextField)
        mainStackView.addArrangedSubview(saveButton)
        
        vStack.setCustomSpacing(Constants.isSE ? 5 : 17, after: avatarView)
        mainStackView.setCustomSpacing(Constants.isSE ? 75 : 185, after: phoneNumberTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            avatarView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.33),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            selectPhotoButton.widthAnchor.constraint(equalTo: avatarView.widthAnchor, multiplier: 0.9),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}

extension ProfileView {
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardChange),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardChange(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardViewFrame = convert(keyboardValue.cgRectValue, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        } else {
            scrollView.contentInset.bottom = keyboardViewFrame.height
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardViewFrame.height
        }
    }
}
