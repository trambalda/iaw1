import UIKit

final class PhoneTextField: UIStackView {
    
    var textFieldShouldReturn: (() -> Void)?
    
    var phoneNumber: PhoneNumber {
        get {
            PhoneNumber(number: textField.text, countryCode: phonePrefixView.countryCode)
        }
        set {
            textField.text = newValue.number
            phonePrefixView.countryCode = newValue.countryCode ?? .default
            refreshPhoneField(for: phonePrefixView.countryCode!)
            updatePlaceholder()
        }
    }
    
    private weak var parent: UIView?
    
    private var isBorderShown: Bool = false {
        didSet {
            containerView.layer.borderWidth = isBorderShown ? 1.2 : 0
        }
    }
    
    private let pickerHeight: CGFloat = 180
    
    private let selfHeight: CGFloat = 80
    
    private let textFieldHeight: CGFloat = 23
    
    private var countryPickerBottomConstraint: NSLayoutConstraint?
    
    private var countryPickerStaticConstraints: [NSLayoutConstraint] = []
    
    private lazy var phonePrefixView: PhonePrefixView = {
        let view = PhonePrefixView()
        view.onCountryPickerToggle = { [weak self] in
            self?.toggleCountryPicker()
        }
        view.onCountryCodeChanged = { [weak self] newCode in
            guard let self, let newCode else { return }
            self.refreshPhoneField(for: newCode)
        }
        view.onBeginEditing = { [weak self] in
            self?.isBorderShown = true
        }
        view.onEndEditing = { [weak self] in
            self?.isBorderShown = false
        }
        return view
    }()
    
    private let titleContainerView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        textField.inputAccessoryView = UIToolbar.doneToolbar(target: self, action: #selector(doneTapped))
        return textField
    }()
    
    private lazy var countryPickerView: CountryPickerView = {
        let view = CountryPickerView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onCountrySelected = { [weak self] country in
            self?.phonePrefixView.countryCode = country
            self?.refreshPhoneField(for: country)
            self?.updatePlaceholder()
        }
        return view
    }()

    init(parent: UIView) {
        self.parent = parent
        super.init(frame: .zero)
        setupStackViewProperties()
        setupLayout()
        setupConstraints()
        configureField(baseStyle: TextFieldBaseStyle())
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
    
    func toggleCountryPicker() {
        if countryPickerView.isHidden {
            showPickerView()
        } else {
            hidePickerView()
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
        parent?.addSubview(countryPickerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: selfHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 13),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -13),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight),
        ])
    }
    
    private func configureField(baseStyle: TextFieldBaseStyle) {
        textField.autocapitalizationType = baseStyle.autocapitalizationType
        textField.textColor = baseStyle.textColor
        textField.backgroundColor = baseStyle.backgroundColor
        textField.font = baseStyle.fontFamily.font
        titleLabel.attributedText = baseStyle.fontFamily.compose(
            "Phone Number",
            color: baseStyle.titleColor
        )
    }
    
    private func updatePlaceholder() {
        let baseStyle = TextFieldBaseStyle()
        textField.attributedPlaceholder = baseStyle.fontFamily.compose(
            phonePrefixView.countryCode?.placeholder ?? "",
            color: baseStyle.placeholderColor
        )
    }
    
    private func refreshPhoneField(for country: CountryCodeModel) {
        phonePrefixView.countryCode = country

        if let text = textField.text {
            let digitsOnly = text.filter { $0.isNumber }
            textField.text = applyMask(for: digitsOnly, with: country.mask)
        }

        updatePlaceholder()
    }
    
    private func applyMask(for text: String, with mask: String) -> String {
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
    
    private func animatePickerView(visible: Bool) {
        if visible {
            countryPickerView.alpha = 0
            countryPickerView.transform = CGAffineTransform(translationX: 0, y: 20)
            countryPickerView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3) {
            self.countryPickerView.alpha = visible ? 1 : 0
            self.countryPickerView.transform = visible ? .identity : CGAffineTransform(translationX: 0, y: 20)
        } completion: { _ in
            if !visible {
                self.countryPickerView.isHidden = true
                self.countryPickerView.transform = .identity
            }
        }
    }
    
    private func showPickerView() {
        isBorderShown = true
        
        let textFieldFrame = convert(bounds, to: nil)

        NSLayoutConstraint.deactivate(countryPickerStaticConstraints)
        countryPickerBottomConstraint?.isActive = false
        
        let leading = countryPickerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = countryPickerView.trailingAnchor.constraint(equalTo: phonePrefixView.trailingAnchor, constant: -11)
        let height = countryPickerView.heightAnchor.constraint(equalToConstant: pickerHeight)
        
        countryPickerStaticConstraints = [leading, trailing, height]
        NSLayoutConstraint.activate(countryPickerStaticConstraints)
        
        let bottomConstraint = countryPickerView.bottomAnchor.constraint(equalTo: containerView.topAnchor)
        bottomConstraint.isActive = true
        countryPickerBottomConstraint = bottomConstraint
        
        if textFieldFrame.minY >= pickerHeight {
            bottomConstraint.constant = 0
        } else {
            bottomConstraint.constant = pickerHeight + selfHeight - textFieldHeight
        }
        
        animatePickerView(visible: true)
    }

    private func hidePickerView() {
        animatePickerView(visible: false)
        
        if !textField.isFirstResponder {
            isBorderShown = false
        }
    }
    
    @objc private func doneTapped() {
        if phonePrefixView.isPrefixFieldFirstResponder == true {
            phonePrefixView.resignTextFieldFirstResponder()
        } else {
            textFieldShouldReturn?()
        }
    }
}

extension PhoneTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldShouldReturn?()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isBorderShown = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isBorderShown = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let rawText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let digits = rawText.filter { $0.isNumber }

        let formattedText = applyMask(for: digits, with: phonePrefixView.countryCode?.mask ?? "")
        textField.text = formattedText
        
        return false
    }
}
