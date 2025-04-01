import UIKit

final class RestaurantViewController: UIViewController {
    private let restaurantView = RestaurantView()
    
    override func loadView() {
        view = restaurantView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantView.scrollView.delegate = self
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let backButton = UIButton(type: .system)
        var backButtonConfig = UIButton.Configuration.plain()
        backButtonConfig.image = .arrowLeft
        backButtonConfig.imagePadding = 7
        backButtonConfig.baseForegroundColor = .dark100
        
        var attributedTitle = AttributedString("Back")
        attributedTitle.font = Font.backButton.font
          
        backButtonConfig.attributedTitle = attributedTitle
        
        backButton.configuration = backButtonConfig
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
       
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage(named: "more"), for: .normal)
        moreButton.tintColor = .dark100
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.tintColor = .dark100
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        let shoppingBagButton = UIButton(type: .system)
        shoppingBagButton.setImage(UIImage(named: "shoppingBag"), for: .normal)
        shoppingBagButton.tintColor = .dark100
        shoppingBagButton.addTarget(self, action: #selector(shoppingBagButtonTapped), for: .touchUpInside)
        
        let rightStack = UIStackView(arrangedSubviews: [moreButton, searchButton, shoppingBagButton])
        rightStack.spacing = 32
        rightStack.alignment = .center
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightStack)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTapped() {
        
    }
    
    @objc private func searchButtonTapped() {
        
    }
    
    @objc private func shoppingBagButtonTapped() {
        
    }
}

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        let newHeaderImageViewHeightConstraint = max(164 - offset, 0)
        let newRestaurantInfoViewHeightConstraint = max(109 - offset / 2, 0)
        
        restaurantView.headerImageViewHeightConstraint.constant = newHeaderImageViewHeightConstraint
        restaurantView.restaurantInfoViewHeightConstraint.constant = newRestaurantInfoViewHeightConstraint
        
        if newHeaderImageViewHeightConstraint == 0 {
            restaurantView.restaurantHeaderView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
            restaurantView.menuTimeView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
            restaurantView.menuCategoryView.transform = CGAffineTransform(translationX: 0, y: -offset + 164)
        } else {
            restaurantView.restaurantHeaderView.transform = .identity
            restaurantView.menuTimeView.transform = .identity
            restaurantView.menuCategoryView.transform = .identity
        }
    }
}
