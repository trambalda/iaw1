import UIKit

class ProfilePhoneNumberInputView: UIView {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Phone Number")
        return label
    }()

    private lazy var phoneTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        return view
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
//        textField.text = "+1 169 916 9564"
        textField.keyboardType = .phonePad
        textField.placeholder = "Введите номер"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var countryCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle(countryCodes.first, for: .normal)
        button.setImage(.arrowDown, for: .normal)
        button.addTarget(self, action: #selector(showCountryPicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private var countryCodes = ["7", "+63"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: true)
        
        let stack = UIStackView(arrangedSubviews: [countryCodeButton, phoneNumberTextField])
        stack.spacing = 8
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            countryCodeButton.widthAnchor.constraint(equalToConstant: 60)
        ])
                                
    }
    
    @objc private func showCountryPicker() {
        phoneNumberTextField.inputView = pickerView
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @objc private func dismissPicker() {
        phoneNumberTextField.resignFirstResponder()
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(phoneTextFieldView)
        phoneTextFieldView.addSubview(phoneNumberTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneTextFieldView.topAnchor, constant: 14),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneTextFieldView.leadingAnchor, constant: 13),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneTextFieldView.trailingAnchor, constant: -13),
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor, constant: -14),
            
            phoneTextFieldView.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
}

extension ProfilePhoneNumberInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCodes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCodeButton.setTitle(countryCodes[row], for: .normal)
    }
    
}
