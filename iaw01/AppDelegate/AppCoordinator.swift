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
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: Constants.isOnboardingCompletedKey)
        if isOnboardingCompleted {
            showMainViewController()
        } else {
            showOnboardingScene()
        }
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
    
    func showVerifyPhoneNumberScene(from parent: UINavigationController?) {
        let vc = factory.createVerifyPhoneNumberScene()
        parent?.pushViewController(vc, animated: true)
    }
    
    func showOnboardingScene() {
        let vc = factory.createOnboardingScene()
        window.rootViewController = vc
    }
    
    // Overload for DummyViewController compatibility
    func showOnboardingScene(from parent: UINavigationController?) {
        showOnboardingScene()
    }
    
}

extension AppCoordinator: OnboardingCoordinator {
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.isOnboardingCompletedKey)
        showMainViewController()
    }
}
