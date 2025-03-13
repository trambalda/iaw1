import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private let presenter: UINavigationController
    private let factory: Factory
    
    private let verify: UIViewController // создан для теста сцены верификации #IAW-25
    
    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
        self.factory = Factory()
        self.verify = VerifyPhoneNumberViewController() // создан для теста сцены верификации #IAW-25
        window.rootViewController = verify // "= presenter" изменен на "verify" для теста сцены верификации #IAW-25
        window.makeKeyAndVisible()
        
        
    }
    
    func start() {
//        showMainViewController() // заккоменчен для теста сцены верификации #IAW-25
        showVerifyViewController() // вызван для теста сцены верификации #IAW-25
    }
    
    func showMainViewController() {
        let rootTabBarController = RootTabBarController(factory: factory)
        window.rootViewController = rootTabBarController
    }
    
    // создан для теста сцены верификации #IAW-25
    func showVerifyViewController() {
        window.rootViewController = VerifyPhoneNumberViewController()
    }
}
