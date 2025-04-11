import UIKit

class EditCheeseburgerView: UIView {
    
    private lazy var editCheeseburgerView: ExpandedViewRow = {
        let view = ExpandedViewRow(labelName: "Edit Cheeseburger", isRequiredLabel: false)
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
        addSubview(editCheeseburgerView)
        
        NSLayoutConstraint.activate([
            editCheeseburgerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            editCheeseburgerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            editCheeseburgerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            editCheeseburgerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17)
        ])
    }
}
