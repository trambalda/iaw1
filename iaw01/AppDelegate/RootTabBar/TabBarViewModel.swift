
import UIKit

final class TabBarViewModel {

    func setupViewControllers(factory: Factory) -> [UINavigationController] {
        [
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createDummyScene()),
            configureController(with: factory.createDummyScene())
        ]
    }

    func createTabItems(with configure: RootTabBarItem) -> [TabBarItem] {
        [
            TabBarItem(
                index: 0,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),
            TabBarItem(
                index: 1,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),
            TabBarItem(
                index: 2,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),
            TabBarItem(
                index: 3,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),
            TabBarItem(
                index: 4,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),
            TabBarItem(
                index: 5,
                title: configure.title,
                image: configure.image,
                selectedImage: configure.selectedImage
            ),

        ]
    }

    private func configureController(with vc: UIViewController) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        return navigationVC
    }
}
