import UIKit

class FullNameView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Full Name")
        return label
    }()

    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your Name"
        return textField
    }()
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = textFieldDelegate
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
        stackView.addArrangedSubview(textFieldView)
        textFieldView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 14),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -13),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -14),
            
            textFieldView.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
}

