import UIKit

class ProfilePhoneNumberInputView: UIView {
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            phoneNumberTextField.delegate = textFieldDelegate
        }
    }
    
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
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.placeholder = "8 800 555 35 35"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberInputView)
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
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberInputView.topAnchor, constant: 14.5),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberInputView.leadingAnchor, constant: 13),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneNumberInputView.trailingAnchor, constant: -13),
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneNumberInputView.bottomAnchor, constant: -14.5),
        ])
    }
}
