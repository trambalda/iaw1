import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let presenter: UINavigationController
    private lazy var factory: Factory = {
        Factory(appCoordinator: self)
    }()
    
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    func start() {
        showMainViewController()
    }
    
    func showMainViewController() {
        let rootTabBarController = RootTabBarController(factory: factory)
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

    func showOnboardingScene(from parent: UINavigationController?) {
        let vc = factory.createOnboardingScene()
        parent?.pushViewController(vc, animated: true)
    }
}
