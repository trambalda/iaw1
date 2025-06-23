import UIKit

protocol HomeScenesCoordinatorProtocol {
    func showTextFieldScene()
    func showCornersButtonsScene()
    func showVerifyPhoneNumberScene()
    func showCartScene()
    func showAuthorizationScene()
    func showRestaurantScene(with id: Int)
    func showOnboardingScene()
    func hideOnboardingScene()
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
    
    func showCartScene() {
        let vc = factory.createCartScene()
		rootViewController.pushViewController(vc, animated: true)
        RootTabBarController.setHidden(to: true)
	}

    func showAuthorizationScene() {
        let vc = factory.createAuthorizationScene()
        rootViewController.pushViewController(vc, animated: true)
    }

    func showRestaurantScene(with id: Int) {
        let vc = factory.createRestaurantScene(with: id)
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func showOnboardingScene() {
        let vc = factory.createOnboardingScene()
        rootViewController.pushViewController(vc, animated: true)
        RootTabBarController.setHidden(to: true)
    }

    func hideOnboardingScene() {
        RootTabBarController.setHidden(to: false)
        rootViewController.popViewController(animated: true)
    }
}
