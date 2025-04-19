import UIKit

class FullNameView: UIView {
    
    weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = textFieldDelegate
        }
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Full Name")
        label.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(textFieldView)
        textFieldView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            
            textFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 14),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -13),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -14),
        ])
    }
}

