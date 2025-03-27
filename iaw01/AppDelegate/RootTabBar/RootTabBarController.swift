import UIKit

final class RootTabBarController: UITabBarController {
    
    var factory: Factory
    private let tabBarModel = TabBarViewModel()

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabBarModel.setupViewControllers(factory: factory), animated: true)
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.backgroundColor = .light80
    }
    

}
