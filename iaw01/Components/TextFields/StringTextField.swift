import UIKit

final class StringTextField: UIStackView {
    
    var textFieldShouldReturn: (() -> Void)?
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .dark100
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius = 14
        view.layer.borderColor = UIColor.dark100.cgColor
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeCircle, for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPassword: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.eye, for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(with style: StringTextFieldStyle) {
        super.init(frame: .zero)
        setupStackViewProperties()
        setupLayout()
        setupConstraints()
        configureField(with: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func becomeTextFieldFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func resignTextFieldFirstResponder() {
        textField.resignFirstResponder()
    }
    
    private func setupStackViewProperties() {
        axis = .vertical
        spacing = 6
    }
    
    private func setupLayout() {
        addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        addArrangedSubview(containerView)
        containerView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 13),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -13),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 23),
        ])
    }
    
    private func configureField(with style: StringTextFieldStyle) {
        let baseStyle = TextFieldBaseStyle()

        textField.autocapitalizationType = baseStyle.autocapitalizationType
        textField.textColor = baseStyle.textColor
        textField.backgroundColor = baseStyle.backgroundColor
        textField.font = baseStyle.fontFamily.font
        textField.text = style.text
        textField.attributedPlaceholder = baseStyle.fontFamily.compose(
            style.placeholder,
            color: baseStyle.placeholderColor
        )

        titleLabel.attributedText = baseStyle.fontFamily.compose(
            style.title ?? "",
            color: baseStyle.titleColor
        )

        textField.isSecureTextEntry = style.behavior.isSecure
        textField.keyboardType = style.behavior.keyboardType
        textField.rightViewMode = .whileEditing
        
        switch style.behavior {
        case .password:
            textField.rightView = showPassword
            textField.isSecureTextEntry = true
        default:
            textField.rightView = clearButton
        }
    }

    @objc private func clearButtonTapped() {
        textField.text = nil
    }
    
    @objc private func showPasswordButtonTapped() {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "eye" : "closedEye"
        showPassword.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension StringTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldShouldReturn?()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderWidth = 1.2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderWidth = 0
    }
}
