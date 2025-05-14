import UIKit

protocol HomeScenesCoordinatorProtocol {
    func showTextFieldScene()
    func showCornersButtonsScene()
    func showVerifyPhoneNumberScene()
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
    
    func showOnboardingScene() {
        let vc = factory.createOnboardingScene()
        vc.hidesBottomBarWhenPushed = true
        rootViewController.pushViewController(vc, animated: true)
        RootTabBarController.setHidden(to: true)
    }

    func hideOnboardingScene() {
        if let previousViewController = rootViewController.viewControllers.last {
            previousViewController.hidesBottomBarWhenPushed = false
            RootTabBarController.setHidden(to: false)
        }
        rootViewController.popViewController(animated: true)
    }
}
