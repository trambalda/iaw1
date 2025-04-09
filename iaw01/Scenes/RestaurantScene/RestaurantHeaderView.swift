import UIKit

final class RestaurantHeaderView: UIStackView {
    
    var model: RestaurantModel = .empty {
        didSet {
            restaurantImage.image = model.logo
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
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        spacing = 22
        alignment = .top
        
        setupLayout()
        setupConstraints()
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
    
    private func setupLayout() {
        let locationStack = UIStackView()
        locationStack.spacing = 4
        locationStack.alignment = .leading
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 2
        infoStack.alignment = .leading
        
        let restaurantStack = UIStackView()
        restaurantStack.spacing = 15
        restaurantStack.alignment = .center
       
        addArrangedSubview(mainStack)
        mainStack.addArrangedSubview(restaurantStack)
        restaurantStack.addArrangedSubview(restaurantImage)
        restaurantStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(restaurantLabel)
        infoStack.addArrangedSubview(locationStack)
        locationStack.addArrangedSubview(locationImage)
        locationStack.addArrangedSubview(locationLabel)
        mainStack.addArrangedSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 64),
            restaurantImage.heightAnchor.constraint(equalToConstant: 64),
            
            locationImage.widthAnchor.constraint(equalToConstant: 19),
            locationImage.heightAnchor.constraint(equalToConstant: 19),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
