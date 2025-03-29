import UIKit

final class PhoneTextField: UIStackView {
    
    var textFieldShouldReturn: (() -> Void)?
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    private let titleContainerView = UIView()
    
    private let phonePrefixView: PhonePrefixView
    
    private var phonePrefix: String = ""
    
    private var currentMask: String = "(###)###-####"

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
        textField.leftViewMode = .always
        textField.leftView = phonePrefixView
        textField.delegate = self
        return textField
    }()
    
    init(with style: PhoneTextFieldStyle, parent: UIView? = nil) {
        self.phonePrefixView = PhonePrefixView(parent: parent)
        super.init(frame: .zero)
        setupStackViewProperties()
        setupLayout()
        setupConstraints()
        configureField(with: style)
        
        phonePrefixView.prefixDidChange = { [weak self] country in
            self?.refreshPhoneField(for: country)
        }
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
    
    func getFullPhoneNumber() -> String? {
        guard let phoneNumber = textField.text else { return nil }
        return phonePrefix + phoneNumber
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
            heightAnchor.constraint(equalToConstant: 80),
            
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
    
    private func configureField(with style: PhoneTextFieldStyle) {
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
    }
    
    private func refreshPhoneField(for country: PhoneCountry) {
        phonePrefix = country.phoneCode
        textField.text = nil
        currentMask = country.mask
    }
    
    private func applyingMask(_ text: String, with mask: String) -> String {
        var result = ""
        var index = text.startIndex
        
        for char in mask {
            if index == text.endIndex {
                break
            }
            
            if char == "#" {
                result.append(text[index])
                index = text.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    private func updateTextFieldState(for string: String) {
        if string.contains(where: { $0.isLetter }) {
            titleLabel.attributedText = Font.body.compose("Введите только цифры", color: .systemRed120)
            containerView.layer.borderColor = UIColor.systemRed120.cgColor
        } else {
            titleLabel.attributedText = Font.body.compose("Phone Number", color: .dark100)
            containerView.layer.borderColor = UIColor.dark100.cgColor
        }
    }
}

extension PhoneTextField: UITextFieldDelegate {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let rawText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let digits = rawText.filter { $0.isNumber }

        updateTextFieldState(for: string)
        
        let formattedText = applyingMask(digits, with: currentMask)
        textField.text = formattedText
        return false
    }
}

