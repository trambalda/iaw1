import UIKit

protocol HomeScenesCoordinatorProtocol {
    func showTextFieldScene()
    func showCornersButtonsScene()
    func showVerifyPhoneNumberScene()
    func showDishScene()
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
    
    func showDishScene() {
        let vc = factory.createDishScene()
        rootViewController.pushViewController(vc, animated: true)
    }
}
