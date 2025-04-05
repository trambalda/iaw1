import UIKit

final class RestaurantView: UIView {
    let scrollView = UIScrollView()
    
    let headerView = HeaderView()
    let menuTimeView = MenuTimeView()
    let menuCategoryView = MenuCategoryView()
    let menuItemListView = MenuItemListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: RestaurantModel) {
        headerView.configure(with: model)
    }
    
    /*
    headerStack
        headerView
    filtersStack
        menuTimeView
        menuCategoryView
    menuItemListView
     */
    
    func setupLayoutAndConstraints() {
        backgroundColor = .light100
        
        let filtersStack = UIStackView(arrangedSubviews: [menuTimeView, menuCategoryView])
        filtersStack.axis = .vertical
        filtersStack.spacing = 18
        filtersStack.alignment = .center
        
        let itemListStack = UIStackView(arrangedSubviews: [menuItemListView])
        itemListStack.axis = .vertical
        
        let contentStack = UIStackView(arrangedSubviews: [headerView, filtersStack, menuItemListView])
        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
