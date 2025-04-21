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
    
    private var state: State = .onboarding

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
        state = .normal
        
        // Проверяем, является ли текущий контроллер OnboardingViewController
        if let navigationController = window.rootViewController as? UINavigationController,
           navigationController.topViewController is OnboardingViewController {
            // Если это корневой экран онбординга, переключаемся на основной экран
            showMainViewController()
        } else if let tabBarController = window.rootViewController as? RootTabBarController {
            // Если это табличный контроллер, показываем таб-бар
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
