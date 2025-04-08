import UIKit

final class HeaderView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            imageView.image = model.image
            restaurantHeaderView.model = model
            restaurantInfoView.model = model
        }
    }
    
    let restaurantHeaderView = RestaurantHeaderView()
    let restaurantInfoView = RestaurantInfoView()
    
    var headerImageViewHeightConstraint: NSLayoutConstraint!
    var restaurantInfoViewHeightConstraint: NSLayoutConstraint!
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let restaurantStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        adjustForSmallScreens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        restaurantStack.addArrangedSubview(restaurantHeaderView)
        restaurantStack.addArrangedSubview(restaurantInfoView)
    
        viewContainer.addSubview(restaurantStack)
    
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(viewContainer)
        
        addSubview(mainStack)
    }
    
    private func setupConstraints() {
        headerImageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            viewContainer.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
            
            restaurantStack.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            restaurantStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor,constant: 16),
            restaurantStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -16),
            restaurantStack.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            headerImageViewHeightConstraint,
            restaurantInfoViewHeightConstraint
        ])
    }
    
    private func adjustForSmallScreens() {
        if Constans.isSE {
            imageView.isHidden = true
            restaurantInfoView.isHidden = true
            headerImageViewHeightConstraint.constant = 0
            restaurantInfoViewHeightConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
