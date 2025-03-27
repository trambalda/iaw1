
import UIKit

final class TabViewModel {

    var factory: Factory

    init(factory: Factory) {
        self.factory = factory
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewControllers() -> [UIViewController] {
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
