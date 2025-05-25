import UIKit

final class CartViewController: UIViewController {
    
    var trendingService: TrendingNetworkServiceProtocol?
    
    var trendingItemsId = 0
    
    private var state: CartState = .empty {
        didSet {
            updateUI(for: state)
        }
    }
    
    private lazy var emptyView = EmptyCartView()
    
    private let filledView = FilledCartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        
        createCustomBackButton()
        setupLayout()
        setupConstraints()
        updateUI(for: state)
        loadTrendingItems()
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        //            self.state = .filled(CartItemModel.examples)
        //        }
        //
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
        //            self.state = .empty
        //        }
    }
    
    private func setupLayout() {
        view.addSubview(emptyView)
        view.addSubview(filledView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filledView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filledView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filledView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filledView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func updateUI(for state: CartState) {
        switch state {
        case .empty:
            emptyView.isHidden = false
            filledView.isHidden = true
        case .filled:
            emptyView.isHidden = true
            filledView.isHidden = false
        }
    }
    
    private func loadTrendingItems() {
        /*
         guard let trendingService = self.trendingService else { return }
                 Task {
                     do {
                         let newAndTrendingsDtos = try await trendingService.fetchItems(id: trendingItemsId)
         
                         if !newAndTrendingsDtos.isEmpty {
                             let newAndTrendingModels = newAndTrendingsDtos.map { $0.model }
                             self.emptyView.newAndTradingView.model = newAndTrendingModels
                         } else {
                             self.emptyView.newAndTradingView.model = []
                         }
         
                     } catch {
                         displayError()
                     }
                 }
         */
        
        let mockModelsForPlaceholderTest: [NewAndTrendingModel] = [
            NewAndTrendingModel(
                id: 1,
                foodImageURL: nil,
                restaurantImageURL: nil,
                restaurantTitle: "Test1",
                distance: "1.0 km"
            ),
            NewAndTrendingModel(
                id: 2,
                foodImageURL: nil,
                restaurantImageURL: nil,
                restaurantTitle: "Test2",
                distance: "2.0 km"
            )
        ]
        self.emptyView.newAndTradingView.model = mockModelsForPlaceholderTest
    }
    
    private func displayError() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить экран", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
