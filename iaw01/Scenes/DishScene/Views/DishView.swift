import UIKit

final class DishView: UIView {
    
    var model: DishModel = .empty {
        didSet {
            dishHeaderView.model = model
        }
    }
    
    let dishHeaderView = DishHeaderView()
    let buttonsBottomView = ButtonsBottomView()
    
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
    
    func addOptionSection(_ view: DishOptionView) {
        contentStackView.addArrangedSubview(view)
    }
    
    private func configure() {
        backgroundColor = .light100
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        buttonsBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(dishHeaderView)
        //contentStackView.addArrangedSubview(dishOptionView)
        addSubview(buttonsBottomView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsBottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsBottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsBottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -RootTabBarController.height - 20),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonsBottomView.topAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
}
