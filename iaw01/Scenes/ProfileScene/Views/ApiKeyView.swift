import UIKit

class ApiKeyView: UIView {
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            apiTextField.delegate = textFieldDelegate
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("API Key")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var apiTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        return view
    }()
    
    private lazy var apiTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your API"
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
        addSubview(label)
        addSubview(apiTextFieldView)
        apiTextFieldView.addSubview(apiTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            
            apiTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            apiTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            apiTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            apiTextField.topAnchor.constraint(equalTo: apiTextFieldView.topAnchor, constant: 14),
            apiTextField.leadingAnchor.constraint(equalTo: apiTextFieldView.leadingAnchor, constant: 13),
            apiTextField.trailingAnchor.constraint(equalTo: apiTextFieldView.trailingAnchor, constant: -13),
            apiTextField.bottomAnchor.constraint(equalTo: apiTextFieldView.bottomAnchor, constant: -14),
        ])
    }
}
