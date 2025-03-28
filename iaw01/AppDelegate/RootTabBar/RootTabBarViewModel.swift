
import UIKit

final class TabBarViewModel {

    func setupViewControllers(factory: Factory) -> [UINavigationController] {
         return [
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createCornersButtonsScene()),
            configureController(with: factory.createTextFieldsScene()),
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createDummyScene())
        ]
    }

    func createTabItems() -> [RootTabBarItem] {
        RootTabBarItem.allCases
    }

    private func configureController(with vc: UIViewController) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        return navigationVC
    }
}
