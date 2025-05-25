import UIKit

class EmptyCartView: UIView {
    
    var imageService: ImageServiceProtocol?
    
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
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(cartIsEmptyLabel)
        addSubview(addressButton)
        addSubview(newAndTradingView)
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cartIsEmptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cartIsEmptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            
            addressButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21),
            addressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            addressButton.heightAnchor.constraint(equalToConstant: 43), //убрать потом когда определимся с компонентой
            
            newAndTradingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            newAndTradingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            newAndTradingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -21)
        ])
    }
}

