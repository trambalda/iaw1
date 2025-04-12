import UIKit

final class RestaurantHeaderView: UIStackView {
    
    var model: RestaurantModel = .empty {
        didSet {
            logoImageView.image = model.logo
            titleLabel.attributedText = Font.name.compose(model.title)
            locationLabel.attributedText = Font.body.compose(model.location)
        }
    }
    
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let locationImage: UIImageView = {
        let image = UIImageView(image: .location)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let favoriteButtonSize: CGFloat = 50
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .light80
        button.layer.cornerRadius = favoriteButtonSize / 2
        button.setImage(.heart, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        spacing = 8
        alignment = .center
        
        setupLayout()
        setupConstraints()
    }
    
    /*
     logoImageView
        infoStack
            titleLabel
            locationStack
                locationImage
                locationLabel
     favoriteButton
     */
    
    private func setupLayout() {
        let locationStack = UIStackView()
        locationStack.spacing = 4
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 0
       
        addArrangedSubview(logoImageView)
        setCustomSpacing(16, after: logoImageView)
        addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(locationStack)
        locationStack.addArrangedSubview(locationImage)
        locationStack.addArrangedSubview(locationLabel)
        addArrangedSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 64),
            logoImageView.heightAnchor.constraint(equalToConstant: 64),
            
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonSize)
        ])
    }
}
