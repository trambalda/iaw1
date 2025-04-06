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
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var headerImageViewHeightConstraint: NSLayoutConstraint!
    var restaurantInfoViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
        adjustForSmallScreens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutAndConstraints() {
        let headerStack = UIStackView()
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(imageView)
       
        let restaurantStack = UIStackView()
        restaurantStack.axis = .vertical
        restaurantStack.spacing = 20
        restaurantStack.alignment = .center
        restaurantStack.translatesAutoresizingMaskIntoConstraints = false
        restaurantStack.addArrangedSubview(restaurantHeaderView)
        restaurantStack.addArrangedSubview(restaurantInfoView)
        
        addSubview(headerStack)
        addSubview(restaurantStack)
        
        headerImageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 164)
        restaurantInfoViewHeightConstraint = restaurantInfoView.heightAnchor.constraint(equalToConstant: 109)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            restaurantStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            restaurantStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            restaurantStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            restaurantStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerImageViewHeightConstraint,
            restaurantInfoViewHeightConstraint
        ])
    }
    
    func adjustForSmallScreens() {
        if UIScreen.main.bounds.height < 670 {
            imageView.isHidden = true
            restaurantInfoView.isHidden = true
            headerImageViewHeightConstraint.constant = 0
            restaurantInfoViewHeightConstraint.constant = 0
        }
    }
}
