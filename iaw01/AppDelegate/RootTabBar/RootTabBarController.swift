import UIKit

final class RootTabBarController: UITabBarController {

    static var height: CGFloat {
        Constans.isSE ? 85 : 120
    }

    var factory: Factory

    private var indicatorCenterConstraint: NSLayoutConstraint?

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        view.clipsToBounds = true
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark100
        view.layer.cornerRadius = 2.5
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
        setViewControllers(setupViewControllers(factory: factory), animated: true)

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        backgroundView.addSubview(stackView)
        view.addSubview(backgroundView)
        view.addSubview(indicatorView)
    }

    private func setupViewControllers(factory: Factory) -> [UINavigationController] {
        [
            UINavigationController(rootViewController: factory.createDummyScene()),
            UINavigationController(rootViewController: factory.createCornersButtonsScene()),
            UINavigationController(rootViewController: factory.createTextFieldsScene()),
            UINavigationController(rootViewController: factory.createDummyScene()),
            UINavigationController(rootViewController: factory.createTextFieldsScene()),
        ]
    }

    private func setupTabBarPages(pages: [RootTabBarItem]) {
        for page in pages {
            let isFirstPage = page == pages.first
            let tabBarItem = createTabBarItem(item: page, isFirst: isFirstPage)

            stackView.addArrangedSubview(tabBarItem)
        }
    }

    private func createTabBarItem(item: RootTabBarItem, isFirst: Bool) -> UIView {
        let tabView = RootTabBarView(item: item)

        if isFirst {
            tabView.verticalAnimation(isUp: true)
        }

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
        let newConstraint = indicatorView.centerXAnchor.constraint(equalTo: item.centerXAnchor)
        indicatorCenterConstraint?.isActive = false

        indicatorCenterConstraint = newConstraint
        indicatorCenterConstraint?.isActive = true

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
            }
    }

    private func setupConstraints() {
        let firstItem = stackView.arrangedSubviews.first!
        let stackTopAnchor: CGFloat = Constans.isSE ? 11 : 16

        indicatorCenterConstraint = indicatorView.centerXAnchor.constraint(equalTo: firstItem.centerXAnchor)
        indicatorCenterConstraint?.isActive = true

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: RootTabBarController.height),

            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: stackTopAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -27),

            indicatorView.heightAnchor.constraint(equalToConstant: 5),
            indicatorView.widthAnchor.constraint(equalToConstant: 5),
            indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 3),
        ])
    }
}
