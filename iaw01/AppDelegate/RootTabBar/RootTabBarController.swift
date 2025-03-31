import UIKit

final class RootTabBarController: UITabBarController {

    var factory: Factory
    private let tabBarModel = TabBarViewModel()
    private var indicatorCenterConstraint: NSLayoutConstraint?

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light80
        view.clipsToBounds = true
        view.addSubview(stack)
        return view
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .dark100
        view.layer.cornerRadius = 2.5
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

        setupTabBarPages(pages: tabBarModel.createTabItems())
        setViewControllers(tabBarModel.setupViewControllers(factory: factory), animated: true)

        setupLayout()
        setupConstraints()
    }

    private func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(indicator)
    }

    private func setupTabBarPages(pages: [RootTabBarItem]) {
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        pages.enumerated().forEach {
            if $0.offset == 0 {
                stack.addArrangedSubview(createOneTabItem(item: $0.element, isFirst: true))
            } else {
                stack.addArrangedSubview(createOneTabItem(item: $0.element, isFirst: false))
            }
        }
    }

    private func createOneTabItem(item: RootTabBarItem, isFirst: Bool = false) -> UIView {
        return TabBarVIews(tabItem: item, isActive: isFirst) { [weak self] selectedItem in
            guard let self = self else { return }

            self.stack.arrangedSubviews.forEach {
                guard let tabBarItem = $0 as? TabBarVIews else { return }
                tabBarItem.isActive = false
            }

            selectedItem.isActive.toggle()
            self.animateIndicator(to: selectedItem)
            self.selectedIndex = RootTabBarItem.allCases.firstIndex(of: item) ?? 0
        }
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

    private func setupConstraints() {

        guard let firstItem = stack.arrangedSubviews.first else { return }
        indicatorCenterConstraint = indicator.centerXAnchor.constraint(equalTo: firstItem.centerXAnchor)
        indicatorCenterConstraint?.isActive = true

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 120),
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 27),
            stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -27)
        ])

        NSLayoutConstraint.activate([
            indicator.heightAnchor.constraint(equalToConstant: 5),
            indicator.widthAnchor.constraint(equalToConstant: 5),
            indicator.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 3)
        ])
    }

}

