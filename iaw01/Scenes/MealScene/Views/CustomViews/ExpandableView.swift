import UIKit

class ExpandableView: UIView {
    
    private var isExpanded = false
    
    private var expandedSubview: UIView?
    
    private var isRequiredLabelNeeded: Bool!
    
    private lazy var expandButton: ExpandableViewsButton = {
        let button = ExpandableViewsButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonTapped() {
        if isExpanded {
            if let expandedSubview = expandedSubview {
                self.removeFromSuperView(expandedSubview)
            }
        } else {
            expandedSubview = createExpandedSubview()
            if let expandedSubview = expandedSubview {
                self.addExpandedSubviewToParent(expandedSubview)
                
                NSLayoutConstraint.activate([
                    expandedSubview.topAnchor.constraint(equalTo: bottomAnchor, constant: 5),
                    expandedSubview.leadingAnchor.constraint(equalTo: leadingAnchor),
                    expandedSubview.trailingAnchor.constraint(equalTo: trailingAnchor),
                    expandedSubview.heightAnchor.constraint(equalToConstant: 56)
                ])
            }
        }
        isExpanded.toggle()
    }
    
    func addExpandedViewWith(image: UIImageView, productName: String, extraPayment: String?, type: AdditionalType) -> UIView {
//        let view = UIView()
//        let stackView = UIStackView()
        
//        let image = image
//        let label = UILabel()
//        label.text = productName
//        let price = UILabel()
//        price.text = extraPayment
//        let type = AdditionalType.Type
        return UIView()
    }
    
    private func createExpandedSubview() -> UIView{
        let view = UIView()
        view.backgroundColor = .light100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func addExpandedSubviewToParent(_ subview: UIView) {
        guard let parentStackView = self.superview as? UIStackView else { return }
        parentStackView.insertArrangedSubview(subview, at: parentStackView.arrangedSubviews.firstIndex(of: self)! + 1)
        
        UIView.animate(withDuration: 0.3) {
            parentStackView.layoutIfNeeded()
        }
    }
    
    private func removeFromSuperView(_ subview: UIView) {
        guard let parentStackView = self.superview as? UIStackView else { return }
        parentStackView.removeArrangedSubview(subview)
        subview.removeFromSuperview()
        
        UIView.animate(withDuration: 0.3) {
            parentStackView.layoutIfNeeded()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var expandedViewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var expandedViewRequiredLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.note.compose("REQUIRED", color: .systemGreen100)
        return label
    }()
    
    private func setupViews(labelName: String, isRequiredLabelNeeded: Bool) {
        expandedViewLabel.attributedText = Font.subtitle2.compose(labelName)
        self.isRequiredLabelNeeded = isRequiredLabelNeeded
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(expandedViewLabel)
        isRequiredLabelNeeded ? stackView.addArrangedSubview(expandedViewRequiredLabel) : nil
        stackView.addArrangedSubview(expandButton)
        isRequiredLabelNeeded ? stackView.setCustomSpacing(12, after: expandedViewRequiredLabel) : nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17)
        ])
    }
    
    init(labelName: String, isRequiredLabel: Bool) {
        super.init(frame: .zero)
        backgroundColor = .light80
        setupViews(labelName: labelName, isRequiredLabelNeeded: isRequiredLabel)
        setupLayout()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
