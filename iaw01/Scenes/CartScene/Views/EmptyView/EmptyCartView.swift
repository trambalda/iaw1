import UIKit

class EmptyCartView: UIView {
    
    var imageService: ImageServiceProtocol?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red 
        return view
    }()
    
    private let addressButton: CornersButton = {
        let button = CornersButton(style: .addressButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cartIsEmptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = Font.emptyStateTitle.compose("EMPTY", color: .dark40)
        return label
    }()
    
    let newAndTradingView = NewAndTrendingView()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(addressButton)
        containerView.addSubview(cartIsEmptyLabel)
        containerView.addSubview(newAndTradingView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21),
            
//            addressButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
//            addressButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 21),
//            addressButton.heightAnchor.constraint(equalToConstant: 43),
//            
//            cartIsEmptyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            cartIsEmptyLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -100),
//            
//            newAndTradingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 21),
//            newAndTradingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -21),
//            newAndTradingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -21)
        ])
    }
}
