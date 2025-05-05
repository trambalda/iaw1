import UIKit

final class DishView: UIView {
    
    var model: DishModel = .empty {
        didSet {
            dishHeaderView.model = model
        }
    }
    
    let dishHeaderView = DishHeaderView()
    //let dishFiltersView = DishFiltersView()
    //let dishButtonsView = DishButtonsView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(dishHeaderView)
        //contentStackView.addArrangedSubview(dishFiltersView)
        //scrollView.addSubview(dishButtonsView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -RootTabBarController.height),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 19),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
}
