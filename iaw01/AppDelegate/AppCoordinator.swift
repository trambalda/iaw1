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
        showMainViewController()
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
}
