import UIKit

final class FiltersView: UIView {
    let menuTimeView = MenuTimeView()
    let menuCategoryView = MenuCategoryView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutAndConstraints() {
        let filtersStack = UIStackView(arrangedSubviews: [menuTimeView, menuCategoryView])
        filtersStack.axis = .vertical
        filtersStack.spacing = 18
        filtersStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(filtersStack)
        
        NSLayoutConstraint.activate([
            filtersStack.topAnchor.constraint(equalTo: topAnchor),
            filtersStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            filtersStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
