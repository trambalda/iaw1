import UIKit

final class RestaurantInfoView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            ratingLabel.attributedText = Font.info.compose("Ratings: \(model.rating)")
            timeLabel.attributedText = Font.info.compose("Delivers in \(model.time) min")
            typeOfFoodLabel.attributedText = Font.info.compose(model.typeOfFood)
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
        button.backgroundColor = .light100
        button.layer.cornerRadius = 25
        button.setImage(.arrowRight, for: .normal)
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
    
    func setupLayoutAndConstraints() {
        backgroundColor = .light60
        layer.cornerRadius = 10
        
        let ratingStack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        ratingStack.spacing = 8
        ratingStack.alignment = .bottom
        
        let timeStack = UIStackView(arrangedSubviews: [timeImage, timeLabel])
        timeStack.spacing = 8
        timeStack.alignment = .bottom
        
        let typeOfFoodStack = UIStackView(arrangedSubviews: [typeOfFoodImage, typeOfFoodLabel])
        typeOfFoodStack.spacing = 8
        typeOfFoodStack.alignment = .bottom
        
        let infoStack = UIStackView(arrangedSubviews: [ratingStack, timeStack, typeOfFoodStack])
        infoStack.axis = .vertical
        infoStack.spacing = 10
        infoStack.alignment = .leading
        
        let mainStack = UIStackView(arrangedSubviews: [infoStack, infoButton])
        mainStack.spacing = 101
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalToConstant: 109),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            ratingImage.heightAnchor.constraint(equalToConstant: 20),
            ratingImage.widthAnchor.constraint(equalToConstant: 20),
            
            timeImage.heightAnchor.constraint(equalToConstant: 18),
            timeImage.widthAnchor.constraint(equalToConstant: 18),
            
            typeOfFoodImage.heightAnchor.constraint(equalToConstant: 16),
            typeOfFoodImage.widthAnchor.constraint(equalToConstant: 16),
            
            infoButton.widthAnchor.constraint(equalToConstant: 50),
            infoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
