import UIKit

protocol CoordinatorProtocol: AnyObject {
    var rootViewController: UINavigationController { get }
    func start()
}

final class AppCoordinator {
    
    enum State {
        case normal
        case onboarding
        case auth
    }
    
    private var state: State = .normal

    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        switch state {
        case .normal:     showMainViewController()
        case .onboarding: break
        case .auth:       break
        }
    }
    
    private func showMainViewController() {
        let homeScenesCoordinator = HomeScenesCoordinator()
        let discoverCoordinator = HomeScenesCoordinator()
        let drivethruCoordinator = HomeScenesCoordinator()
        let ordersCoordinator = HomeScenesCoordinator()
        let profileCoordinator = HomeScenesCoordinator()
        
        homeScenesCoordinator.start()
        discoverCoordinator.start()
        drivethruCoordinator.start()
        ordersCoordinator.start()
        profileCoordinator.start()
        
        let tabBarControllers = [
            homeScenesCoordinator.rootViewController,
            discoverCoordinator.rootViewController,
            drivethruCoordinator.rootViewController,
            ordersCoordinator.rootViewController,
            profileCoordinator.rootViewController,
        ]

        let rootTabBarController = RootTabBarController(with: tabBarControllers)
        window.rootViewController = rootTabBarController
    }
    
    func showTextFieldScene(from parent: UINavigationController?) {
        let vc = factory.createTextFieldsScene()
        parent?.pushViewController(vc, animated: true)
    }
    
    func showCornersButtonsScene(from parent: UINavigationController?) {
        let vc = factory.createCornersButtonsScene()
        parent?.pushViewController(vc, animated: true)
    }
    
    func showVerifyPhoneNumberScene(from parent: UINavigationController?) {
        let vc = factory.createVerifyPhoneNumberScene()
        parent?.pushViewController(vc, animated: true)
    }
}
