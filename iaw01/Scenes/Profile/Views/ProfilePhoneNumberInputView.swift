import UIKit

class ProfilePhoneNumberInputView: UIView {
    
    private var isCountryCodeButtonTapped = false
    
    private let codes = CountryCodes.countries
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Phone Number")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius =  15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var countryCodeLabel: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.text = codes.first?.code
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var countryCodeButton: UIButton = {
        let button = UIButton()
        button.setImage(codes.first!.flag, for: .normal)
        button.addTarget(self, action: #selector(showCountryPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .light60
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "000 000 0000"
        textField.keyboardType = .phonePad
        addDoneButtonOnNumpad(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addDoneButtonOnNumpad(textField: UITextField) {
        let keypadToolbar: UIToolbar = UIToolbar()
        keypadToolbar.items=[
            UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItem.Style.done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            ),
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: self,
                action: nil)
        ]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
    
    private func setupLayout() {
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberInputView)
        phoneNumberInputView.addSubview(countryCodeLabel)
        phoneNumberInputView.addSubview(countryCodeButton)
        phoneNumberInputView.addSubview(separatorLabel)
        phoneNumberInputView.addSubview(phoneNumberTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            
            phoneNumberInputView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 6),
            phoneNumberInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneNumberInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            countryCodeLabel.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            countryCodeLabel.leadingAnchor.constraint(equalTo: phoneNumberInputView.leadingAnchor, constant: 13),
            countryCodeLabel.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            
            countryCodeButton.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 15),
            countryCodeButton.leadingAnchor.constraint(equalTo: countryCodeLabel.trailingAnchor, constant: 4),
            countryCodeButton.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            
            separatorLabel.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14),
            separatorLabel.leadingAnchor.constraint(equalTo: countryCodeButton.trailingAnchor, constant: 10),
            countryCodeButton.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor, constant: 10),
            countryCodeButton.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
        ])
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
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

extension ProfilePhoneNumberInputView: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        codes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

extension ProfilePhoneNumberInputView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var countryCode: [String] = []
        var countryFlag: [UIImage] = []
        
        for code in codes {
            countryCode.append(code.code)
            countryFlag.append(code.flag)
        }
        countryCodeButton.setImage(countryFlag[row], for: .normal)
        return countryCode[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var array: [String] = []
        for code in codes {
            array.append(code.code)
        }
        countryCodeLabel.text = array[row]
    }
}
