import UIKit

final class FiltersView: UIView {
    
    var model: RestaurantModel = .empty {
        didSet {
            menuTimeView.configure(with: model.menu)
        }
    }
    
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
        let filtersStack = UIStackView()
        filtersStack.axis = .vertical
        filtersStack.spacing = 18
        filtersStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(filtersStack)
        
        filtersStack.addArrangedSubview(menuTimeView)
        filtersStack.addArrangedSubview(menuCategoryView)
        
        NSLayoutConstraint.activate([
            filtersStack.topAnchor.constraint(equalTo: topAnchor),
            filtersStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            filtersStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            filtersStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
