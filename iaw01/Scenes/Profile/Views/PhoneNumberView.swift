import UIKit

class PhoneNumberView: UIView {

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
        textField.text = "+1 169 916 9564"
        textField.keyboardType = .numberPad
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
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneTextFieldView.bottomAnchor, constant: -14)
        ])
    }
}
