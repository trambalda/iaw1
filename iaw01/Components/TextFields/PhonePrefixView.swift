import UIKit

final class PhonePrefixView: UIView {
    
    var prefixDidChange: ((String) -> Void)?
    
    private let countryCodes = [
        ("US", "+1"), ("BY", "+375"), ("FR", "+33"), ("RU", "+7")
    ]
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    private let phonePrefixLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("+1", color: .dark60)
        return label
    }()
    
    private lazy var showPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.downChevron, for: .normal)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        return button
    }()

    private lazy var phonePrefixPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .light80
        return picker
    }()
    
    private lazy var pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }()
    
    private lazy var pickerTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = phonePrefixPicker
        textField.inputAccessoryView = pickerToolbar
        return textField
    }()
    
    private lazy var lineContainerView = UIView()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light60
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(phonePrefixLabel)
        containerStackView.addArrangedSubview(showPickerButton)
        containerStackView.addArrangedSubview(lineContainerView)
        lineContainerView.addSubview(lineView)
        addSubview(pickerTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineContainerView.widthAnchor.constraint(equalToConstant: 20),
            
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineContainerView.centerXAnchor, constant: -2),
            lineView.topAnchor.constraint(equalTo: lineContainerView.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: lineContainerView.bottomAnchor),
        ])
    }
    
    @objc private func showPicker() {
        pickerTextField.becomeFirstResponder()
    }
    
    @objc private func doneButtonTapped() {
        pickerTextField.resignFirstResponder()
    }
}

extension PhonePrefixView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryCodes[row].1) (\(countryCodes[row].0))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedPrefix = countryCodes[row].1
        phonePrefixLabel.attributedText = Font.body.compose(countryCodes[row].1, color: .dark100)
        prefixDidChange?(selectedPrefix)
    }
}

extension PhonePrefixView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countryCodes.count
    }
}
