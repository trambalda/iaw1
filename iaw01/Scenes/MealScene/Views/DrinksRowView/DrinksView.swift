import UIKit

class DrinksView: UIView {
    
    private lazy var drinksView: ExpandedViewRow = {
        let view = ExpandedViewRow(labelName: "Drinks", isRequiredLabel: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .light80
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(drinksView)
        
        NSLayoutConstraint.activate([
            drinksView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            drinksView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            drinksView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            drinksView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17)
        ])
    }
}
