import UIKit

final class StringTextField: UIView {
    
    private let fieldTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.body
        label.textColor = UIColor(resource: .dark100)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(resource: .light80)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.rightView = clearButton
        field.rightViewMode = .whileEditing
        field.delegate = self
        return field
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .closeCircle), for: .normal)
        button.tintColor = UIColor(resource: .dark80)
        button.addAction(UIAction { [weak self] _ in
            self?.clearButtonTapped()
        }, for: .touchUpInside)
        return button
    }()
    
    init(with style: StringTextFieldStyle) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        configureField(with: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(fieldTitleLabel)
        addSubview(containerView)
        containerView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fieldTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            fieldTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            fieldTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: fieldTitleLabel.bottomAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 51),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -13),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func configureField(with style: StringTextFieldStyle) {
        let baseStyle = style.baseStyle
        
        textField.text = style.text
        textField.autocapitalizationType = baseStyle.autocapitalizationType
        textField.textColor = baseStyle.textColor
        textField.backgroundColor = baseStyle.backgroundColor
        textField.font = baseStyle.fontFamily
        textField.keyboardType = style.keyboardType ?? .default
        
        fieldTitleLabel.text = style.title
        
        if let attributedPlaceholder = baseStyle.attributedPlaceholder {
            textField.attributedPlaceholder = attributedPlaceholder
        } else {
            textField.placeholder = style.placeholder
        }
    }
    
    private func clearButtonTapped() {
        textField.text = nil
    }
}

extension StringTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor(resource: .dark100).cgColor
        containerView.layer.borderWidth = 1.2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 0
    }
}

