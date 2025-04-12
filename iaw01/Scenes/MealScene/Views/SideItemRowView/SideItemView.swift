import UIKit

class SideItemView: UIView {
    
    private lazy var isExpanded = false
    
    private lazy var expandedView: SideItemExpandedView = {
        let view = SideItemExpandedView()
        return view
    }()
    
    private lazy var sideItemView: ExpandableView = {
        let view = ExpandableView(labelName: "Side Item", isRequiredLabel: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        addSubview(sideItemView)
        
        NSLayoutConstraint.activate([
            sideItemView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            sideItemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            sideItemView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            sideItemView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .light80
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
