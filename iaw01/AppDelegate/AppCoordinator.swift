import UIKit

protocol CoordinatorProtocol: AnyObject {
    var rootViewController: UINavigationController { get }
    func start()
}

extension UserDefaults {
    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    var hasCompletedOnboarding: Bool {
        get { bool(forKey: Keys.hasCompletedOnboarding) }
        set { 
            set(newValue, forKey: Keys.hasCompletedOnboarding)
            synchronize()
        }
    }
}

final class AppCoordinator {
    
    enum State {
        case normal
        case onboarding
        case auth
    }
    
    private var state: State {
        if UserDefaults.standard.hasCompletedOnboarding {
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
        UserDefaults.standard.hasCompletedOnboarding = true
        
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
        let coordinators = (0..<5).map { _ in
            HomeScenesCoordinator(appCoordinator: self)
        }
        
        coordinators.forEach { $0.start() }
        
        let tabBarControllers = coordinators.map { $0.rootViewController }

        let rootTabBarController = RootTabBarController(with: tabBarControllers)
        window.rootViewController = rootTabBarController
    }
}
