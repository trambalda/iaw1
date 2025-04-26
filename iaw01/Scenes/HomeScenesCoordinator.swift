import UIKit

protocol HomeScenesCoordinatorProtocol {
    func showTextFieldScene()
    func showCornersButtonsScene()
    func showVerifyPhoneNumberScene()
    func showOnboardingScene()
}

final class HomeScenesCoordinator: CoordinatorProtocol, HomeScenesCoordinatorProtocol {
    
    private(set) var rootViewController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    private lazy var factory: HomeScenesFactory = {
        HomeScenesFactory(coordinator: self)
    }()
    
    init(appCoordinator: AppCoordinator? = nil) {
        self.appCoordinator = appCoordinator
    }
    
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
    
    func showOnboardingScene() {
        let vc = factory.createOnboardingScene()
        RootTabBarController.setHidden(to: true)
        rootViewController.pushViewController(vc, animated: true)
    }
}
