import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let presenter: UINavigationController
    private let factory: Factory
    
    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
        self.factory = Factory()
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    func start() {
        //showMainViewController()
        let changeLocationVC = ChangeLocationViewController()
        UINavigationController().pushViewController(changeLocationVC, animated: true)
    }
    
    func showMainViewController() {
        let rootTabBarController = RootTabBarController(factory: factory)
        window.rootViewController = rootTabBarController
    }
    
    
}
