import UIKit

class ExpandedView: UIView {
    
    private var isExpanded = false
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var isRequiredLabelNeeded = true
    
    private lazy var requiredLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.caption.compose("REQUIRED", color: .systemGreen100)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(.addButton, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    init(title: String, isRequiredLabelNeeded: Bool) {
        super.init(frame: .zero)
        self.label.attributedText = Font.subtitle2.compose(title)
        self.isRequiredLabelNeeded = isRequiredLabelNeeded
        backgroundColor = .light80
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        isExpanded.toggle()
        isExpanded ? button.setImage(.removeButton, for: .normal) : button.setImage(.addButton, for: .normal)
    }
    
    private func setupLayout() {
        addSubview(stack)
        stack.addArrangedSubview(label)
        isRequiredLabelNeeded ? stack.addArrangedSubview(requiredLabel) : nil
        stack.addArrangedSubview(button)
        stack.setCustomSpacing(isRequiredLabelNeeded ? 12 : 0, after: requiredLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17)
        ])
    }
    
    private func populateWithContent(content: [Content]) {
        
        
    }

}
