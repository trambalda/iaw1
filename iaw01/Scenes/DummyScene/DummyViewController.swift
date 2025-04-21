import UIKit

final class DummyViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinatorProtocol?
    
    private let restaurantService: RestaurantServiceProtocol
    private var loadedRestaurant: RestaurantModel?
    
    private lazy var dummyView: DummyView = {
        let view = DummyView(frame: .zero)
        view.scenes = SceneModel.models
        view.route = { sceneType in
            self.route(to: sceneType)
        }
        return view
    }()
    
    init(restaurantService: RestaurantServiceProtocol) {
        self.restaurantService = restaurantService
        super.init(nibName: nil, bundle: nil)
        loadRestaurant()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = dummyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationItem.title = "Scenes"
    }
    
    private func loadRestaurant() {
        Task {
            do {
                guard let restaurant = try await restaurantService.fetchRestaurant(id: 1) else {
                    print("⚠️ Ресторан с id 1 не найден")
                    return
                }
                
                self.loadedRestaurant = restaurant
                print("✅ Загрузили ресторан: \(restaurant.name)")
            } catch {
                print("❌ Ошибка загрузки ресторана: \(error)")
            }
        }
    }
    
    private func route(to sceneType: SceneType) {
        switch sceneType {
        case .textFiedsScene:
            coordinator?.showTextFieldScene()
        case .cornersButtonsScene:
            coordinator?.showCornersButtonsScene()
        case .verifyPhoneNumberScene:
            coordinator?.showVerifyPhoneNumberScene()
        case .restaurantScene:
            if let restaurant = loadedRestaurant {
                coordinator?.showRestaurantScene(with: restaurant.id)
            } else {
                print("⚠️ Ресторан еще не загружен")
            }
        }
    }
}
