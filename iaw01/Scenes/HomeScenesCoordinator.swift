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
    
    private func showScene<T: UIViewController>(_ viewController: T, hideTabBar: Bool = false) {
        if hideTabBar {
            RootTabBarController.setHidden(to: true)
        }
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func showTextFieldScene() {
        showScene(factory.createTextFieldsScene())
    }
    
    func showCornersButtonsScene() {
        showScene(factory.createCornersButtonsScene())
    }
    
    func showVerifyPhoneNumberScene() {
        showScene(factory.createVerifyPhoneNumberScene())
    }
    
    func showOnboardingScene() {
        showScene(factory.createOnboardingScene(), hideTabBar: true)
    }
    
    func hideOnboardingScene() {
        RootTabBarController.setHidden(to: false)
    }
}
