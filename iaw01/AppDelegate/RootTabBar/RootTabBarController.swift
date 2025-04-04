import UIKit

final class RootTabBarController: UITabBarController {

    var factory: Factory
    private var indicatorCenterConstraint: NSLayoutConstraint?

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        view.clipsToBounds = true
        return view
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var indicator: UIView = {
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
        backgroundView.addSubview(stack)
        view.addSubview(backgroundView)
        view.addSubview(indicator)
    }

    private func animateIndicator(to item: UIView) {
        let newConstraint = indicator.centerXAnchor.constraint(equalTo: item.centerXAnchor)
        indicatorCenterConstraint?.isActive = false

        indicatorCenterConstraint = newConstraint
        indicatorCenterConstraint?.isActive = true

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5, options: [.curveEaseInOut]) { [weak self] in
                guard let self else { return }
                self.view.layoutIfNeeded()
            }
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
            stack.addArrangedSubview(setupTabBarItem(item: page, isFirst: isFirstPage))
        }
    }

    private func setupTabBarItem(item: RootTabBarItem, isFirst: Bool = false) -> UIView {
        let tabView = RootTabBarView(tabItem: item, isActive: isFirst)
        tabView.onTap = { [weak self] selectedItem in
            guard let self else { return }

            self.stack.arrangedSubviews.forEach {
                guard let tabBarItem = $0 as? RootTabBarView else { return }
                tabBarItem.isActive = false
            }

            selectedItem.isActive.toggle()
            self.animateIndicator(to: selectedItem)
            self.selectedIndex = RootTabBarItem.allCases.firstIndex(of: item) ?? 0
        }

        return tabView
    }

    private func setupConstraints() {
        guard let firstItem = stack.arrangedSubviews.first else { return }

        let tabBarHeight: CGFloat = UIScreen.main.bounds.height < 700 ? 85 : 120
        let stackTopAnchor: CGFloat = UIScreen.main.bounds.height < 700 ? 11 : 16

        indicatorCenterConstraint = indicator.centerXAnchor.constraint(equalTo: firstItem.centerXAnchor)
        indicatorCenterConstraint?.isActive = true

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: tabBarHeight),

            stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: stackTopAnchor),
            stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 27),
            stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -27),

            indicator.heightAnchor.constraint(equalToConstant: 5),
            indicator.widthAnchor.constraint(equalToConstant: 5),
            indicator.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 3),
        ])
    }
}
