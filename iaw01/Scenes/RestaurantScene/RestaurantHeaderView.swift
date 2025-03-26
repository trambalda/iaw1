import UIKit

final class RestaurantHeaderView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            restaurantImage.image = model.logo ?? UIImage(systemName: "photo")
            restaurantLabel.text = model.title
            locationLabel.text = model.location
        }
    }
    
    private let restaurantImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = Font.name.font
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
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
        let locationStack = UIStackView()
        locationStack.spacing = 4
        locationStack.alignment = .leading
        locationStack.addArrangedSubview(locationImage)
        locationStack.addArrangedSubview(locationLabel)
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 2
        infoStack.alignment = .leading
        infoStack.addArrangedSubview(restaurantLabel)
        infoStack.addArrangedSubview(locationStack)
        
        let restaurantStack = UIStackView()
        restaurantStack.spacing = 15
        restaurantStack.alignment = .leading
        restaurantStack.addArrangedSubview(restaurantImage)
        restaurantStack.addArrangedSubview(infoStack)
        
        let mainStack = UIStackView()
        mainStack.spacing = 22
        mainStack.alignment = .top
        mainStack.addArrangedSubview(restaurantStack)
        mainStack.addArrangedSubview(favoriteButton)
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            mainStack.leadingAnchor.constraint(equalTo: leftAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 64),
            restaurantImage.heightAnchor.constraint(equalToConstant: 64),
            
            locationImage.widthAnchor.constraint(equalToConstant: 19),
            locationImage.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
}
