import UIKit

class CartView: UIView {

    private let emptyView = EmptyCartView()
    
    private let filledView = FilledCartView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .light100
        
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureEmptyState(with trendingItems: [NewAndTrendingModel]) {
        emptyView.isHidden = false
        filledView.isHidden = true
        emptyView.newAndTradingView.model = trendingItems
    }
    
//    func configureFilledState(with cartItems: ) {
//        emptyView.isHidden = true
//        filledView.isHidden = false
//    }
    
    private func setupLayout() {
        addSubview(emptyView)
        addSubview(filledView)
    }
    
    private func setupConstraints() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        filledView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filledView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filledView.bottomAnchor.constraint(equalTo: bottomAnchor),
            filledView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filledView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
