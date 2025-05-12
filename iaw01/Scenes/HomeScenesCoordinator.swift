import UIKit

protocol HomeScenesCoordinatorProtocol {
    func showTextFieldScene()
    func showCornersButtonsScene()
    func showVerifyPhoneNumberScene()
    func showAuthorizationScene()
    func showRestaurantScene(with id: Int)
}

final class HomeScenesCoordinator: CoordinatorProtocol, HomeScenesCoordinatorProtocol {
    
    private(set) var rootViewController = UINavigationController()
    
    private lazy var factory: HomeScenesFactory = {
        HomeScenesFactory(coordinator: self)
    }()
    
    func start() {
        rootViewController.pushViewController(factory.createDummyScene(), animated: false)
    }
    
    func showTextFieldScene() {
        let vc = factory.createTextFieldsScene()
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showCornersButtonsScene() {
        let vc = factory.createCornersButtonsScene()
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showVerifyPhoneNumberScene() {
        let vc = factory.createVerifyPhoneNumberScene()
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showAuthorizationScene() {
        let vc = factory.createAuthorizationScene()
        rootViewController.pushViewController(vc, animated: true)
    }

    func showRestaurantScene(with id: Int) {
        let vc = factory.createRestaurantScene(with: id)
        rootViewController.pushViewController(vc, animated: true)
    }
}
