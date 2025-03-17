import UIKit

final class RootTabBarController: UITabBarController {
    
    var factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.backgroundColor = UIColor(resource: .light80)
        viewControllers = [
            configureController(with: factory.createHomeScene(), tabBarItem: .home),
            configureController(with: factory.createDummyScene(), tabBarItem: .discover),
            configureController(with: factory.createDummyScene(), tabBarItem: .drivethru),
            configureController(with: factory.createDummyScene(), tabBarItem: .orders),
            configureController(with: factory.createDummyScene(), tabBarItem: .profile),
        ]
    }
    
    private func configureController(with vc: UIViewController, tabBarItem: RootTabBarItem) -> UINavigationController {
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.title = tabBarItem.title
        nc.tabBarItem.image = tabBarItem.image
        return nc
    }
}
