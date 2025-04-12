import UIKit

final class RootTabBarController: UITabBarController {

    static var height: CGFloat {
        Constans.isSE ? 85 : 120
    }

    var factory: Factory

    private var indicatorViewCenterXConstraint: NSLayoutConstraint?
    
    private lazy var tabBarControllers: [UINavigationController] = [
        UINavigationController(rootViewController: factory.createDummyScene()),
        UINavigationController(rootViewController: factory.createDummyScene()),
        UINavigationController(rootViewController: factory.createDummyScene()),
        UINavigationController(rootViewController: factory.createDummyScene()),
        UINavigationController(rootViewController: factory.createDummyScene()),
    ]

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        view.clipsToBounds = true
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private let indicatorView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .indicatorView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true

        setupTabBarPages(pages: RootTabBarItem.allCases)
        setViewControllers(tabBarControllers, animated: true)

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        backgroundView.addSubview(stackView)
        backgroundView.addSubview(indicatorView)
        view.addSubview(backgroundView)
    }

    private func setupTabBarPages(pages: [RootTabBarItem]) {
        for page in pages {
            let tabBarItem = createTabBarItem(item: page)

            stackView.addArrangedSubview(tabBarItem)
        }

        if let firstPage = stackView.arrangedSubviews.first as? RootTabBarView {
            firstPage.verticalAnimation(isUp: true)
        }
    }

    private func createTabBarItem(item: RootTabBarItem) -> RootTabBarView {
        let tabView = RootTabBarView(item: item)

        tabView.onTap = { [weak self] selectedItem in
            guard let self else { return }

            self.stackView.arrangedSubviews.forEach {
                guard let tabBarItem = $0 as? RootTabBarView else { return }
                tabBarItem.verticalAnimation(isUp: tabBarItem == selectedItem)
            }

            self.animateIndicator(to: selectedItem)
            self.selectedIndex = RootTabBarItem.tabIndex(of: item)
        }

        return tabView
    }

    private func animateIndicator(to item: UIView) {
        indicatorViewCenterXConstraint?.isActive = false
        indicatorViewCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: item.centerXAnchor)
        indicatorViewCenterXConstraint?.isActive = true

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: [.curveEaseInOut]
        ) {
            self.view.layoutIfNeeded()
        }
    }

    private func setupConstraints() {
        let stackTopAnchor: CGFloat = Constans.isSE ? 11 : 16

        indicatorViewCenterXConstraint = indicatorView.centerXAnchor.constraint(
            equalTo: stackView.arrangedSubviews.first!.centerXAnchor
        )

        indicatorViewCenterXConstraint?.isActive = true

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: RootTabBarController.height),

            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: stackTopAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -27),

            indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 2),
        ])
    }
}
