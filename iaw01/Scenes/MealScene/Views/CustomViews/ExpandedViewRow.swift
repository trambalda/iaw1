import UIKit

class ExpandedViewRow: UIStackView {
    
    private var isRequiredLabelNeeded: Bool!
    
    var expandedButton = ExpandedButton()
    
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
    
    private func configureAndSetupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(expandedViewLabel)
        isRequiredLabelNeeded ? addArrangedSubview(expandedViewRequiredLabel) : nil
        addArrangedSubview(expandedButton)
        
        isRequiredLabelNeeded ? setCustomSpacing(12, after: expandedViewRequiredLabel) : nil
    }
    
    init(labelName: String, isRequiredLabel: Bool) {
        super.init(frame: .zero)
        setupViews(labelName: labelName, isRequiredLabelNeeded: isRequiredLabel)
        configureAndSetupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
