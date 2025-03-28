import UIKit

final class RootTabBarController: UITabBarController {

    var factory: Factory
    private let tabBarModel = TabBarViewModel()

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
    }

    private func setupTabBarPages(pages: [RootTabBarItem]) {
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
            self.selectedIndex = RootTabBarItem.allCases.firstIndex(of: item) ?? 0
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 120),
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 27),
            stack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -27),
        ])
    }

}

