import UIKit

final class RestaurantView: UIView {
    
    var model: RestaurantModel = .empty {
        didSet {
            headerView.model = model
            filterView.model = model
            menuItemListView.models = model.dishes
            
            let cellHeight: CGFloat = MenuItemsTableViewCell.cellHeight
            let totalHeight = CGFloat(model.dishes.count) * cellHeight
            menuItemListViewHeightConstraint?.constant = totalHeight
        }
    }
    
    let headerView = HeaderView()
    let filterView = MenuTimeView()
    let menuItemListView = MenuItemsTableView()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var menuItemListViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        contentStack.addArrangedSubview(headerView)
        contentStack.addArrangedSubview(filterView)
        contentStack.addArrangedSubview(menuItemListView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        menuItemListViewHeightConstraint = menuItemListView.heightAnchor.constraint(equalToConstant: 0)
        menuItemListViewHeightConstraint?.isActive = true
    }
}

extension RestaurantView: UIScrollViewDelegate {
    
}
