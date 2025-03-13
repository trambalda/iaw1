import UIKit

final class CustomTextFieldView: UIView {
    
    private let containerView: CustomTextFieldContainerView = {
        let view = CustomTextFieldContainerView()
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
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.addAction(UIAction { [weak self] _ in
            self?.textField.text = ""
        }, for: .touchUpInside)
        return button
    }()
    
    private let type: TextFieldType
    
    init(type: TextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func applyStyle() {
        switch type {
        case .name:
            textField.applyCommonStyle(placeholder: "Enter your Name", keyboardType: .default)
        case .email:
            textField.applyCommonStyle(placeholder: "Enter your Email", keyboardType: .emailAddress)
        }
    }
}

extension CustomTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.dark100.cgColor
        containerView.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = 0
    }
}

enum TextFieldType {
    case name
    case email
}
