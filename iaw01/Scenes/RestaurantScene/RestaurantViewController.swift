import UIKit

final class RestaurantViewController: UIViewController {
    
    var restaurantId: Int = 0
    var restaurantService: RestaurantNetworkServiceProtocol?
    
    private lazy var restaurantView: RestaurantView = {
        let imageService = ImageService()
        let view = RestaurantView()
        view.imageService = imageService
        view.headerView.imageService = imageService
        view.menuItemListView.imageService = imageService
        return view
    }()
    
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
        if let restaurantService = restaurantService {
            Task {
                do {
                    let restaurantsDto = try await restaurantService.fetchRestaurant(id: restaurantId)
                    
                    if let restaurantDto = restaurantsDto.first {
                        restaurantView.model = restaurantDto.toModel()
                    } else {
                        displayError()
                    }
                } catch {
                    displayError()
                }
            }
        } else {
            displayError()
        }
    }
   
    private func displayError() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить экран", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
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
