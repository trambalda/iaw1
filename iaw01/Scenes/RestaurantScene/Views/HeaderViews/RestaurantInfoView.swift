import UIKit

final class RestaurantInfoView: UIView {
    
    var model: RestaurantModel = .empty {
        didSet {
            ratingLabel.attributedText = Font.info.compose("Ratings: \(model.rating)")
            timeLabel.attributedText = Font.info.compose("Delivers in \(model.deliveryTime) min")
            typeOfFoodLabel.attributedText = Font.info.compose(model.cousines.joined(separator: ", "))
        }
    }
    
    private let ratingLabel = UILabel()
    private let timeLabel = UILabel()
    private let typeOfFoodLabel = UILabel()
    
    private let ratingImage: UIImageView = {
        let image = UIImageView(image: .star)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let timeImage: UIImageView = {
        let image = UIImageView(image: .boxTime)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let typeOfFoodImage: UIImageView = {
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
    
    private let mainStack: UIStackView = {
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
        let ratingStack = UIStackView()
        ratingStack.spacing = 8
        ratingStack.alignment = .bottom
        
        let timeStack = UIStackView()
        timeStack.spacing = 8
        timeStack.alignment = .bottom
        
        let typeOfFoodStack = UIStackView()
        typeOfFoodStack.spacing = 8
        typeOfFoodStack.alignment = .bottom
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 10
        infoStack.alignment = .leading
        
        addSubview(mainStack)
        mainStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(ratingStack)
        ratingStack.addArrangedSubview(ratingImage)
        ratingStack.addArrangedSubview(ratingLabel)
        infoStack.addArrangedSubview(timeStack)
        timeStack.addArrangedSubview(timeImage)
        timeStack.addArrangedSubview(timeLabel)
        infoStack.addArrangedSubview(typeOfFoodStack)
        typeOfFoodStack.addArrangedSubview(typeOfFoodImage)
        typeOfFoodStack.addArrangedSubview(typeOfFoodLabel)
        mainStack.addArrangedSubview(infoButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
