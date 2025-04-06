import UIKit

final class RestaurantView: UIView {
    var model: RestaurantModel = .mock {
        didSet {
            headerView.model = model
            filtersView.model = model
        }
    }
    
    let scrollView = UIScrollView()
    
    let headerView = HeaderView()
    let filtersView = FiltersView()
    let menuItemListView = MenuItemListView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .light100
        setupLayoutAndConstraints()
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
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        contentStack.addArrangedSubview(headerView)
        contentStack.addArrangedSubview(filtersView)
        contentStack.addArrangedSubview(menuItemListView)
        
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
