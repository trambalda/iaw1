import UIKit

final class CartViewController: UIViewController {
    
    var trendingService: TrendingNetworkServiceProtocol?
    
    var trendingItemsId = 0
    
    private lazy var cartView: CartView = {
        let view = CartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        testDisplayEmptyState()
    }
    
    private func testDisplayEmptyState() {
        let mockModels: [NewAndTrendingModel] = [
            NewAndTrendingModel(id: 1, foodImageURL: nil, restaurantImageURL: nil, restaurantTitle: "Test1 из CartView", distance: "1.0 km"),
            NewAndTrendingModel(id: 2, foodImageURL: nil, restaurantImageURL: nil, restaurantTitle: "Test2 из CartView", distance: "2.0 km")
        ]
        
        cartView.configureEmptyState(with: mockModels)
    }
    
    private func displayError() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить экран", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
