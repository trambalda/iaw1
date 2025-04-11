import UIKit

class SideItemView: UIView {
    
    private lazy var isExpanded = false
    
    private lazy var expandedView: SideItemExpandedView = {
        let view = SideItemExpandedView()
        return view
    }()
    
    private lazy var sideItemView: ExpandedViewRow = {
        let view = ExpandedViewRow(labelName: "Side Item", isRequiredLabel: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func buttonTapped() {
        sideItemView.expandedButton.onTap = { [weak self] in
            let view = SideItemExpandedView()
            self?.addSubview(view)
            self?.isExpanded.toggle()
            print("Action")
            
            if self?.isExpanded == true {
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: (self?.sideItemView.bottomAnchor)!, constant: 6),
                    view.leadingAnchor.constraint(equalTo: (self?.sideItemView.leadingAnchor)!),
                    view.trailingAnchor.constraint(equalTo: (self?.sideItemView.trailingAnchor)!),
                    view.bottomAnchor.constraint(equalTo: (self?.sideItemView.bottomAnchor)!, constant: 12),
                    view.heightAnchor.constraint(equalToConstant: 134)
                ])
            }
        }
        
    }
    
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
        buttonTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
