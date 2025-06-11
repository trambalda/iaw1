import UIKit

final class RestaurantView: UIView {
    
    var imageService: ImageServiceProtocol? {
        didSet {
            headerView.imageService = imageService
            menuItemListView.imageService = imageService
        }
    }
    
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
    
    private var menuItemListViewHeightConstraint: NSLayoutConstraint?
    
    private var selectedMenu: MenuModel?
    private var filterIsSticky: Bool = false
    private var userDidScroll: Bool = false
    private var bottomSpacerHeightConstraint: NSLayoutConstraint?
    
    private lazy var filterStickyView: MenuTimeView = {
        let view = MenuTimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomSpacerView: UIView = {
        let view = UIView()
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
        //scrollViewDidScroll(scrollView)
    }
    
    private func setupCallbacks() {
        let onMenuSelected: (MenuModel?) -> Void = { [weak self] selectedMenu in
            self?.selectedMenu = selectedMenu
            self?.filterView.selectMenu(selectedMenu)
            self?.filterStickyView.selectMenu(selectedMenu)
            self?.updateMenuItems(for: selectedMenu)
            
            DispatchQueue.main.async {
                guard let self else { return }
                self.scrollViewDidScroll(self.scrollView)
            }
        }
        
        filterView.onMenuSelected = onMenuSelected
        filterStickyView.onMenuSelected = onMenuSelected
    }
    
    private func updateMenuItems(for menu: MenuModel?) {
        guard let menu else { return }

        let dishes = model.dishes.filter { menu.dishesId.contains($0.id) }
        menuItemListView.models = dishes

        let cellHeight: CGFloat = MenuItemsTableViewCell.cellHeight
        let totalHeight = CGFloat(dishes.count) * cellHeight
        menuItemListViewHeightConstraint?.constant = totalHeight

        layoutIfNeeded()

        let visibleHeight = scrollView.frame.height
        let contentHeight = headerView.frame.height + filterView.frame.height + totalHeight
        let minimumPadding = visibleHeight - contentHeight - 20

        bottomSpacerHeightConstraint?.constant = max(minimumPadding, 0)
        bottomSpacerView.isHidden = minimumPadding <= 0

        userDidScroll = false

        DispatchQueue.main.async {
            self.layoutIfNeeded()
            self.scrollView.layoutIfNeeded()

            DispatchQueue.main.async {
                self.scrollViewDidScroll(self.scrollView)
            }
        }
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
        contentStack.addArrangedSubview(menuItemListView)
        contentStack.addArrangedSubview(bottomSpacerView)
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
        
        filterStickyView.alpha = 0
        
        menuItemListViewHeightConstraint = menuItemListView.heightAnchor.constraint(equalToConstant: 0)
        menuItemListViewHeightConstraint?.isActive = true
        
        bottomSpacerHeightConstraint = bottomSpacerView.heightAnchor.constraint(equalToConstant: 0)
        bottomSpacerHeightConstraint?.isActive = true
    }
}

extension RestaurantView: UIScrollViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
        print("contentSize.height: \(scrollView.contentSize.height)")
        print("scrollView.frame.height: \(scrollView.frame.height)")
        
        guard scrollView.contentSize.height > 0, scrollView.frame.height > 0 else {
               print("⚠️ Skip scroll event — layout not ready yet")
               return
           }

        let isContentScrollable = scrollView.contentSize.height > scrollView.frame.height
        print("isContentScrollable: \(isContentScrollable)")

        if !isContentScrollable {
            toggleFilterStickyView(isSticky: true)
            return
        }

        let filterViewFrameInSuperview = filterView.convert(filterView.bounds, to: self)
        let shouldStick = filterViewFrameInSuperview.minY <= safeAreaInsets.top
        print("filterViewFrame.minY: \(filterViewFrameInSuperview.minY)")
        print("safeAreaInsets.top: \(safeAreaInsets.top)")
        print("shouldStick: \(shouldStick)")
        
        toggleFilterStickyView(isSticky: shouldStick)
    }

    private func toggleFilterStickyView(isSticky: Bool) {

        if isSticky {
            let offset = filterView.getScrollOffset()
            filterStickyView.setScrollOffset(offset)
        } else {
            let offset = filterStickyView.getScrollOffset()
            filterView.setScrollOffset(offset)
        }

        filterStickyView.alpha = isSticky ? 1 : 0
        filterStickyView.isUserInteractionEnabled = isSticky
        filterIsSticky = isSticky
    }
}
