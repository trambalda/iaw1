import UIKit

final class RestaurantHeaderView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            restaurantImage.image = model.logo ?? UIImage(systemName: "photo")
            restaurantLabel.attributedText = Font.name.compose(model.title)
            locationLabel.attributedText = Font.body.compose(model.location)
        }
    }
    
    private let restaurantLabel = UILabel()
    private let locationLabel = UILabel()
    
    private let restaurantImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let locationImage: UIImageView = {
        let image = UIImageView(image: .location)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .light80
        button.layer.cornerRadius = 25
        button.setImage(.heart, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     mainStack
        restaurantStack
            restaurantImage
            infoStack
                restaurantLabel
                locationStack
                    locationImage
                    locationLabel
        favoriteButton
     */
    
    func  setupLayoutAndConstraints() {
        let locationStack = UIStackView(arrangedSubviews: [locationImage, locationLabel])
        locationStack.spacing = 4
        locationStack.alignment = .leading
        
        let infoStack = UIStackView(arrangedSubviews: [restaurantLabel, locationStack])
        infoStack.axis = .vertical
        infoStack.spacing = 2
        infoStack.alignment = .leading
        
        let restaurantStack = UIStackView(arrangedSubviews: [restaurantImage, infoStack])
        restaurantStack.spacing = 15
        restaurantStack.alignment = .leading
        
        let mainStack = UIStackView(arrangedSubviews: [restaurantStack, favoriteButton])
        mainStack.spacing = 22
        mainStack.alignment = .top
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 64),
            restaurantImage.heightAnchor.constraint(equalToConstant: 64),
            
            locationImage.widthAnchor.constraint(equalToConstant: 19),
            locationImage.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
}
