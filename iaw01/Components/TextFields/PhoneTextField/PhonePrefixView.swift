import UIKit

final class PhonePrefixView: UIView {
    
    var onCountryPickerToggle: (() -> Void)?
    
    var onCountryCodeChanged: (() -> Void)?
    
    var onBeginEditing: (() -> Void)?
    
    var onEndEditing: (() -> Void)?
    
    var countryCode: CountryCodeModel? = .default {
        didSet {
            guard let countryCode else { return }
            flagLabel.text = countryCode.flag
            phonePrefixTextField.attributedText = Font.body.compose(countryCode.code, color: .dark100)
        }
    }
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    private let phonePrefixStackView = UIStackView()
    
    private lazy var flagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var flagContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagLabel)
        view.widthAnchor.constraint(equalToConstant: 25).isActive = true
        return view
    }()

    private lazy var phonePrefixTextField: UITextField = {
        let textField = UITextField()
        textField.leftViewMode = .always
        textField.leftView = flagContainerView
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var showPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.downChevron, for: .normal)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineContainerView = UIView()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light60
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(phonePrefixStackView)
        phonePrefixStackView.addArrangedSubview(phonePrefixTextField)
        containerStackView.addArrangedSubview(showPickerButton)
        containerStackView.addArrangedSubview(lineContainerView)
        lineContainerView.addSubview(lineView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            phonePrefixStackView.widthAnchor.constraint(equalToConstant: 67),
            
            lineContainerView.widthAnchor.constraint(equalToConstant: 20),
            
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineContainerView.centerXAnchor, constant: -2),
            lineView.topAnchor.constraint(equalTo: lineContainerView.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: lineContainerView.bottomAnchor),
            
            flagLabel.leadingAnchor.constraint(equalTo: flagContainerView.leadingAnchor),
            flagLabel.trailingAnchor.constraint(equalTo: flagContainerView.trailingAnchor),
            flagLabel.topAnchor.constraint(equalTo: flagContainerView.topAnchor),
            flagLabel.bottomAnchor.constraint(equalTo: flagContainerView.bottomAnchor),
        ])
    }
    
    @objc private func showPicker() {
        onCountryPickerToggle?()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        
        if let country = CountryCodeModel.countryCodes.first(where: { $0.code == text }) {
            countryCode = country
        } else {
            countryCode = CountryCodeModel(code: text)
        }
        onCountryCodeChanged?()
    }
}

extension PhonePrefixView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if string == "+" || (range.location == 0 && string.isEmpty) {
            return false
        }
        
        let shouldChange = newText.count <= CountryCodeModel.maxLength
        
        if newText.count == CountryCodeModel.maxLength {
            DispatchQueue.main.async {
                textField.resignFirstResponder()
            }
        }
        return shouldChange
    }
}
