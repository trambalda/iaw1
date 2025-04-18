import UIKit

class InputView: UIView {
    
    private var isCountryCodeButtonTapped = false
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .light60
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Phone Number")
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "987 222 0377"
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var countryCodeLabel: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.text = countryCodes.first
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phoneNumberInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius =  15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var countryCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle(countryCodes.first, for: .normal)
        button.setImage(.arrowDown, for: .normal)
        button.addTarget(self, action: #selector(showCountryPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var countryCodes = ["+7", "+63", "+38", "+88"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(phoneNumberLabel)
        stackView.addArrangedSubview(phoneNumberInputView)
        phoneNumberInputView.addSubview(countryCodeLabel)
        phoneNumberInputView.addSubview(countryCodeButton)
        phoneNumberInputView.addSubview(separatorLabel)
        phoneNumberInputView.addSubview(phoneNumberTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countryCodeLabel.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            countryCodeLabel.leadingAnchor.constraint(equalTo: phoneNumberInputView.leadingAnchor, constant: 13),
            countryCodeLabel.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            countryCodeLabel.widthAnchor.constraint(equalToConstant: 35),
            
            countryCodeButton.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            countryCodeButton.leadingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor, constant: 4),
            countryCodeButton.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            countryCodeButton.widthAnchor.constraint(equalToConstant: 22),
            
            separatorLabel.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            separatorLabel.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 10),
            separatorLabel.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 10),
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
        ])
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: true)
        countryCodeLabel.inputAccessoryView = toolbar
    }
    
    @objc private func showCountryPicker() {
        isCountryCodeButtonTapped.toggle()
        if isCountryCodeButtonTapped {
            countryCodeLabel.isUserInteractionEnabled.toggle()
            countryCodeLabel.inputView = pickerView
            countryCodeLabel.becomeFirstResponder()
        }
    }
    
    @objc private func dismissPicker() {
        isCountryCodeButtonTapped.toggle()
        countryCodeLabel.isUserInteractionEnabled.toggle()
        countryCodeLabel.resignFirstResponder()
    }
    
}

extension InputView: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countryCodes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

extension InputView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countryCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCodeLabel.text = countryCodes[row]
    }
}
