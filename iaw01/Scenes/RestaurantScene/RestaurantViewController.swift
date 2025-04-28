import UIKit

final class RestaurantViewController: UIViewController {
    
    private let restaurantId: Int
    private let restaurantService: RestaurantNetworkServiceProtocol
    private var loadedRestaurant: RestaurantModel?
    
    private lazy var restaurantView: RestaurantView = {
        let imageService = ImageService()
        let view = RestaurantView()
        view.imageService = imageService
        view.headerView.imageService = imageService
        view.menuItemListView.imageService = imageService
        return view
    }()
    
    init(id: Int, restaurantService: RestaurantNetworkServiceProtocol) {
            self.restaurantId = id
            self.restaurantService = restaurantService
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = restaurantView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        loadRestaurant()
    }
    
    private func setupNavigationBar() {
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
        rightStack.alignment = .center
        rightStack.spacing = 28
        
        /* РЕАЛИЗОВАТЬ ПОЗЖЕ
         
        if Constants.isSE {
            rightStack.spacing = 16
        } else if screenHeight < 800 {
            rightStack.spacing = 24
        } else {
            rightStack.spacing = 32
        }
        */
        
        let rightBarButtonItem = UIBarButtonItem(customView: rightStack)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    private func loadRestaurant() {
        Task {
            do {
            
                guard let restaurant = try await restaurantService.fetchRestaurant(id: restaurantId) else {
                    return
                }
                self.loadedRestaurant = restaurant
                self.restaurantView.model = restaurant
                print("🍽️ Загружен ресторан: \(restaurant.name)")
            } catch let error {
                print("❌ Ошибка загрузки ресторана: \(error)")
            }
        }
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
