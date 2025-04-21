import UIKit

final class RestaurantInfoView: UIView {
    
    var model: RestaurantModel = .empty {
        didSet {
            ratingLabel.attributedText = Font.info.compose("Ratings: \(model.rating)")
            deliveryTimeLabel.attributedText = Font.info.compose("Delivers in \(model.deliveryTime) min")
            cousinesLabel.attributedText = Font.info.compose(model.cousines.joined(separator: ", "))
        }
    }
    
    private let ratingLabel = UILabel()
    private let deliveryTimeLabel = UILabel()
    private let cousinesLabel = UILabel()
    
    private let ratingImageView: UIImageView = {
        let image = UIImageView(image: .star)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let deliveryTimeImageView: UIImageView = {
        let image = UIImageView(image: .boxTime)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let cousinesImageView: UIImageView = {
        let image = UIImageView(image: .element)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.moreInfo, for: .normal)
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 101
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .light80
        layer.cornerRadius = 10
        setupLayout()
        setupConstraints()
    }
    
    /*
     mainStack
        infoStack
            ratingStack
                ratingImage
                ratingLabel
            timeStack
                timeImage
                timeLabel
            typeOfFoodStack
                typeOfFoodImage
                typeOfFoodLabel
        infoButton
     */
    
    private func setupLayout() {
        let ratingStackView = UIStackView()
        ratingStackView.spacing = 8
        ratingStackView.alignment = .bottom
        
        let timeStackView = UIStackView()
        timeStackView.spacing = 8
        timeStackView.alignment = .bottom
        
        let typeOfFoodStackView = UIStackView()
        typeOfFoodStackView.spacing = 8
        typeOfFoodStackView.alignment = .bottom
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 10
        infoStackView.alignment = .leading
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(ratingStackView)
        ratingStackView.addArrangedSubview(ratingImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        infoStackView.addArrangedSubview(timeStackView)
        timeStackView.addArrangedSubview(deliveryTimeImageView)
        timeStackView.addArrangedSubview(deliveryTimeLabel)
        infoStackView.addArrangedSubview(typeOfFoodStackView)
        typeOfFoodStackView.addArrangedSubview(cousinesImageView)
        typeOfFoodStackView.addArrangedSubview(cousinesLabel)
        mainStackView.addArrangedSubview(infoButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
