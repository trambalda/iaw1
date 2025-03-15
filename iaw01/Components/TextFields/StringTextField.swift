import UIKit

final class StringTextField: UIStackView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.body
        label.textColor = .dark100
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .closeCircle), for: .normal)
        button.tintColor = .dark80
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(with style: StringTextFieldStyle) {
        super.init(frame: .zero)
        setupStackViewProperties()
        setupLayout()
        setupConstraints()
        configureField(with: style)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackViewProperties() {
        axis = .vertical
        spacing = 6
        alignment = .fill
        distribution = .fill
    }
    
    private func setupLayout() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(containerView)
        containerView.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            
            containerView.heightAnchor.constraint(equalToConstant: 51),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -13),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 23),
        ])
    }
    
    private func configureField(with style: StringTextFieldStyle) {
        let baseStyle = style.baseStyle
        
        textField.autocapitalizationType = baseStyle.autocapitalizationType
        textField.textColor = baseStyle.textColor
        textField.backgroundColor = baseStyle.backgroundColor
        textField.font = baseStyle.fontFamily
        textField.text = style.text
        textField.keyboardType = style.keyboardType ?? .default
        textField.attributedPlaceholder = style.attributedPlaceholder
        
        titleLabel.text = style.title
    }
    
    @objc private func clearButtonTapped() {
        textField.text = nil
    }
}

extension StringTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.dark100.cgColor
        containerView.layer.borderWidth = 1.2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 0
    }
}

