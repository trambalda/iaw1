import UIKit

final class RestaurantView: UIView {
    
    var imageService: ImageServiceProtocol?
    
    var model: RestaurantModel = .empty {
        didSet {
            headerView.model = model
            filterView.model = model
            filterStickyView.model = model
            menuItemListView.imageService = imageService
            
            filterView.selectMenu(selectedMenu)
            filterStickyView.selectMenu(selectedMenu)
        }
    }
    
    let headerView = HeaderView()
    let filterView = MenuTimeView()
    let menuItemListView = MenuItemsTableView()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var menuItemListViewHeightConstraint: NSLayoutConstraint?
    
    private var selectedMenu: MenuModel?
    private var filterIsSticky: Bool = false
    
    private lazy var filterStickyView: MenuTimeView = {
        let view = MenuTimeView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCallbacks()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollViewDidScroll(scrollView)
    }
    
    private func setupCallbacks() {
        let onMenuSelected: (MenuModel?) -> Void = { [weak self] selectedMenu in
            self?.selectedMenu = selectedMenu
            self?.filterView.selectMenu(selectedMenu)
            self?.filterStickyView.selectMenu(selectedMenu)
            self?.updateMenuItems(for: selectedMenu)
        }
        
        filterView.onMenuSelected = onMenuSelected
        filterStickyView.onMenuSelected = onMenuSelected
    }
    
    private func updateMenuItems(for menu: MenuModel?) {
        guard let menu else { return }
        let dishes = model.dishes.filter { menu.dishesId.contains($0.id) }
        
        let currentOffset = scrollView.contentOffset
        
        menuItemListView.models = dishes

        let cellHeight: CGFloat = MenuItemsTableViewCell.cellHeight
        let totalHeight = CGFloat(dishes.count) * cellHeight
        menuItemListViewHeightConstraint?.constant = totalHeight
        
        layoutIfNeeded()
        scrollView.setContentOffset(currentOffset, animated: false)
    }
    
    private func configure() {
        backgroundColor = .light100
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        addSubview(filterStickyView)
        
        contentStack.addArrangedSubview(headerView)
        contentStack.addArrangedSubview(filterView)
        contentStack.addArrangedSubview(spacerView)
        contentStack.addArrangedSubview(menuItemListView)
    }
   
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -RootTabBarController.height),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            filterStickyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filterStickyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterStickyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterStickyView.heightAnchor.constraint(equalToConstant: 59),
        ])
        
        spacerView.heightAnchor.constraint(equalToConstant: 59).isActive = true
       
        menuItemListViewHeightConstraint = menuItemListView.heightAnchor.constraint(equalToConstant: 0)
        menuItemListViewHeightConstraint?.isActive = true
    }
}

extension RestaurantView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let headerHeight = headerView.frame.height
        
        if offsetY >= headerHeight {
            toggleFilterStickyView(isSticky: true)
        } else {
            toggleFilterStickyView(isSticky: false)
        }
    }
    
    private func toggleFilterStickyView(isSticky: Bool) {
        guard isSticky != filterIsSticky else { return }
        
        if isSticky {
            let offset = filterView.scrollView.contentOffset
            filterStickyView.scrollView.setContentOffset(offset, animated: false)
        } else {
            let offset = filterStickyView.scrollView.contentOffset
            filterView.scrollView.setContentOffset(offset, animated: false)
        }
        
        filterStickyView.isHidden = !isSticky
        filterView.isHidden = isSticky
        filterIsSticky = isSticky
        
        spacerView.isHidden = !isSticky
    }
}
