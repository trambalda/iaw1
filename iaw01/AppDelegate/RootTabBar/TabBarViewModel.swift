
import UIKit

final class TabBarViewModel {
    
    func setupViewControllers(factory: Factory) -> [UINavigationController] {
        [
            configureController(with: factory.createDummyScene(), tabBarItem: .home),
            configureController(with: factory.createDummyScene(), tabBarItem: .discover),
            configureController(with: factory.createDummyScene(), tabBarItem: .drivethru),
            configureController(with: factory.createDummyScene(), tabBarItem: .orders),
            configureController(with: factory.createDummyScene(), tabBarItem: .profile)
        ]
    }

    private func configureController(with vc: UIViewController, tabBarItem: RootTabBarItem) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.tabBarItem.title = tabBarItem.title
        navigationVC.tabBarItem.image = tabBarItem.image
        return navigationVC
    }
}
