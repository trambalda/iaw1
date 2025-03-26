import UIKit

final class RestaurantViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let navigationBarView = NavigationBarView()
    private let headerImageView = HeaderImageView()
    private let restaurantHeaderView = RestaurantHeaderView()
    private let restaurantInfoView = RestaurantInfoView()
    private let menuTimeView = MenuTimeView()
    private let menuCategoryView = MenuCategoryView()
    private let menuItemListView = MenuItemListView()
    
    private var headerImageViewHeightConstraint: NSLayoutConstraint!
    private var restaurantInfoViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutAndConstraints()
        scrollView.delegate = self
    }
    
    func setupLayoutAndConstraints() {
        view.backgroundColor = .white
        view.addSubview(navigationBarView)
        
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerImageView)
        contentView.addSubview(restaurantHeaderView)
        contentView.addSubview(restaurantInfoView)
        contentView.addSubview(menuTimeView)
        contentView.addSubview(menuCategoryView)
        contentView.addSubview(menuItemListView)
        
        [navigationBarView, headerImageView, restaurantHeaderView, restaurantInfoView, menuTimeView, menuCategoryView, menuItemListView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        headerImageViewHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),
            
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerImageViewHeightConstraint,
            
            restaurantHeaderView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 22),
            restaurantHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            restaurantHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            restaurantHeaderView.heightAnchor.constraint(equalToConstant: 66),
            
            restaurantInfoView.topAnchor.constraint(equalTo: restaurantHeaderView.bottomAnchor, constant: 20),
            restaurantInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            restaurantInfoView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -21),
            restaurantInfoViewHeightConstraint,
            
            menuTimeView.topAnchor.constraint(equalTo: restaurantInfoView.bottomAnchor, constant: 18),
            menuTimeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuTimeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuTimeView.heightAnchor.constraint(equalToConstant: 59),
            
            menuCategoryView.topAnchor.constraint(equalTo: menuTimeView.bottomAnchor, constant: 18),
            menuCategoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            menuCategoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            menuCategoryView.heightAnchor.constraint(equalToConstant: 40),
            
            menuItemListView.topAnchor.constraint(equalTo: menuCategoryView.bottomAnchor, constant: 9),
            menuItemListView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            menuItemListView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            menuItemListView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        let newHeaderImageViewHeightConstraint = max(164 - offset, 0)
        let newRestaurantInfoViewHeightConstraint = max(109 - offset / 2, 0)
        
        headerImageViewHeightConstraint.constant = newHeaderImageViewHeightConstraint
        restaurantInfoViewHeightConstraint.constant = newRestaurantInfoViewHeightConstraint
        
        if newHeaderImageViewHeightConstraint == 0 {
            restaurantHeaderView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
            menuTimeView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
            menuCategoryView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
        } else {
            restaurantHeaderView.transform = .identity
            menuTimeView.transform = .identity
            menuCategoryView.transform = .identity
        }
    }
}
