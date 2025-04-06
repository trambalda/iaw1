import UIKit

final class RestaurantInfoView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            ratingLabel.attributedText = Font.info.compose("Ratings: \(model.rating)")
            timeLabel.attributedText = Font.info.compose("Delivers in \(model.time) min")
            typeOfFoodLabel.attributedText = Font.info.compose(model.typeOfFood.isEmpty ? "Нет данных" : model.typeOfFood)
        }
    }
    
    //private let ratingLabel = UILabel()
    //private let timeLabel = UILabel()
    //private let typeOfFoodLabel = UILabel()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = Font.info.font
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.info.font
        return label
    }()
    
    private let typeOfFoodLabel: UILabel = {
        let label = UILabel()
        label.font = Font.info.font
        return label
    }()
    
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
        translatesAutoresizingMaskIntoConstraints = false
        
        let ratingStack = UIStackView()
        ratingStack.spacing = 8
        ratingStack.alignment = .bottom
        ratingStack.addArrangedSubview(ratingImage)
        ratingStack.addArrangedSubview(ratingLabel)
        
        let timeStack = UIStackView()
        timeStack.spacing = 8
        timeStack.alignment = .bottom
        timeStack.addArrangedSubview(timeImage)
        timeStack.addArrangedSubview(timeLabel)
        
        let typeOfFoodStack = UIStackView()
        typeOfFoodStack.spacing = 8
        typeOfFoodStack.alignment = .bottom
        typeOfFoodStack.addArrangedSubview(typeOfFoodImage)
        typeOfFoodStack.addArrangedSubview(typeOfFoodLabel)
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 10
        infoStack.alignment = .leading
        infoStack.addArrangedSubview(ratingStack)
        infoStack.addArrangedSubview(timeStack)
        infoStack.addArrangedSubview(typeOfFoodStack)
        
        let mainStack = UIStackView()
        mainStack.spacing = 101
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(infoButton)
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
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
