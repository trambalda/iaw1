import UIKit

final class PhoneTextField: UIStackView {
    
    var textFieldShouldReturn: (() -> Void)?
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    private weak var parent: UIView?
    
    private lazy var phonePrefixView = PhonePrefixView(parent: self)
    
    private var phonePrefix: String = ""
    
    private var currentMask: String = ""
    
    private let titleContainerView = UIView()

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
        textField.keyboardType = .phonePad
        textField.leftViewMode = .always
        textField.leftView = phonePrefixView
        textField.delegate = self
        return textField
    }()
    
    private lazy var countryPickerView: CountryPickerView = {
        let view = CountryPickerView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onCountrySelected = { [weak self] country in
            self?.phonePrefixView.selectedCountry = country
            self?.refreshPhoneField(for: country)
        }
        return view
    }()
    
    init(with style: PhoneTextFieldStyle, parent: UIView?) {
        self.parent = parent
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
    
    var phoneNumber: PhoneNumber {
        PhoneNumber(number: textField.text, countryCode: phonePrefix)
    }
    
    func toggleCountryPicker() {
        if countryPickerView.isHidden {
            showPickerView()
        } else {
            hidePickerView()
        }
    }
    
    func updatePhonePrefix(with code: String) {
        phonePrefix = code
        textField.text = nil
        
        if let country = CountryCodeModel.countryCodes.first(where: { $0.code == code }) {
            currentMask = country.mask
            phonePrefixView.selectedCountry = country
        } else {
            currentMask = CountryCodeModel.defaultMask
            phonePrefixView.selectedCountry = nil
        }
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
    
    private func refreshPhoneField(for country: CountryCodeModel) {
        phonePrefix = country.code
        textField.text = nil
        currentMask = country.mask
    }
    
    private func applyingMask(for text: String, with mask: String) -> String {
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
    
    private func showPickerView() {
        parent?.addSubview(countryPickerView)
        
        if let parentView = parent {
            let textFieldFrame = convert(bounds, to: nil)
            var visibleHeight = parentView.bounds.height
            
            if let scrollView = parentView as? UIScrollView {
                visibleHeight += scrollView.contentOffset.y
            }
            
            if textFieldFrame.maxY + 200 > visibleHeight {
                NSLayoutConstraint.activate([
                    countryPickerView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
                    countryPickerView.heightAnchor.constraint(equalToConstant: 160),
                    countryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    countryPickerView.trailingAnchor.constraint(equalTo: phonePrefixView.trailingAnchor, constant: -11),
                ])
            } else {
                NSLayoutConstraint.activate([
                    countryPickerView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
                    countryPickerView.heightAnchor.constraint(equalToConstant: 160),
                    countryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    countryPickerView.trailingAnchor.constraint(equalTo: phonePrefixView.trailingAnchor, constant: -11),
                ])
            }
        }

        countryPickerView.alpha = 0
        countryPickerView.transform = CGAffineTransform(translationX: 0, y: 20)
        countryPickerView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.countryPickerView.alpha = 1
            self.countryPickerView.transform = .identity
        }
    }
    
    private func hidePickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.countryPickerView.transform = CGAffineTransform(translationX: 0, y: 20)
            self.countryPickerView.alpha = 0
        }) { _ in
            self.countryPickerView.isHidden = true
            self.countryPickerView.transform = .identity
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
        
        let formattedText = applyingMask(for: digits, with: currentMask)
        textField.text = formattedText
        
        let maxPhoneLength = currentMask.filter { $0 == "#" }.count
        
        if digits.count >= maxPhoneLength {
            textFieldShouldReturn?()
        }
        return false
    }
}
