import UIKit

class ApiKeyView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("API Key")
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
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            apiTextField.delegate = textFieldDelegate
        }
    }
    
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
        stackView.addArrangedSubview(apiTextFieldView)
        apiTextFieldView.addSubview(apiTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            apiTextField.topAnchor.constraint(equalTo: apiTextFieldView.topAnchor, constant: 14),
            apiTextField.leadingAnchor.constraint(equalTo: apiTextFieldView.leadingAnchor, constant: 13),
            apiTextField.trailingAnchor.constraint(equalTo: apiTextFieldView.trailingAnchor, constant: -13),
            apiTextField.bottomAnchor.constraint(equalTo: apiTextFieldView.bottomAnchor, constant: -14),
            
            apiTextFieldView.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
}
