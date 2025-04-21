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
    
    private enum UserDefaultsKeys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    private var state: State {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasCompletedOnboarding) {
            return .normal
        } else {
            return .onboarding
        }
    }

    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        switch state {
        case .normal:     showMainViewController()
        case .onboarding: showOnboardingViewController()
        case .auth:       break
        }
    }
    
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.hasCompletedOnboarding)
        UserDefaults.standard.synchronize()
        
        if let navigationController = window.rootViewController as? UINavigationController,
           navigationController.topViewController is OnboardingViewController {
            showMainViewController()
        } else if let tabBarController = window.rootViewController as? RootTabBarController {
            tabBarController.customTabBarHidden = false
        }
    }
    
    func showOnboardingViewController() {
        let factory = Factory(appCoordinator: self)
        let onboardingVC = factory.createOnboardingScene()
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
    }
    
    private func showMainViewController() {
        let homeScenesCoordinator = HomeScenesCoordinator(appCoordinator: self)
        let discoverCoordinator = HomeScenesCoordinator(appCoordinator: self)
        let drivethruCoordinator = HomeScenesCoordinator(appCoordinator: self)
        let ordersCoordinator = HomeScenesCoordinator(appCoordinator: self)
        let profileCoordinator = HomeScenesCoordinator(appCoordinator: self)
        
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
