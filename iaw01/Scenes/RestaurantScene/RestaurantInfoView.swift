import UIKit

final class RestaurantInfoView: UIView {
    var model: RestaurantModel = .empty {
        didSet {
            ratingLabel.text = "Ratings: \(model.rating)"
            timeLabel.text = "Delivers in \(model.time) min"
            typeOfFoodLabel.text = model.typeOfFood
        }
    }
    
    private let contentView = UIView()
    
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
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Ratings:"
        label.font = Font.info.font
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivers in "
        label.font = Font.info.font
        return label
    }()
   
    private let typeOfFoodLabel: UILabel = {
        let label = UILabel()
        label.font = Font.info.font
        return label
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
    
    func setupLayoutAndConstraints() {
        contentView.backgroundColor = .dark60
        contentView.layer.cornerRadius = 10
        addSubview(contentView)
        
        let ratingStack = UIStackView()
        ratingStack.spacing = 7
        ratingStack.alignment = .leading
        ratingStack.addArrangedSubview(ratingImage)
        ratingStack.addArrangedSubview(ratingLabel)
        
        let timeStack = UIStackView()
        timeStack.spacing = 8
        timeStack.alignment = .leading
        timeStack.addArrangedSubview(timeImage)
        timeStack.addArrangedSubview(timeLabel)
        
        let typeOfFoodStack = UIStackView()
        typeOfFoodStack.spacing = 9
        typeOfFoodStack.alignment = .leading
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
        mainStack.alignment = .center
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(infoButton)
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            contentView.heightAnchor.constraint(equalToConstant: 109),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            ratingImage.heightAnchor.constraint(equalToConstant: 20),
            ratingImage.widthAnchor.constraint(equalToConstant: 20),
            
            timeImage.heightAnchor.constraint(equalToConstant: 18),
            timeImage.widthAnchor.constraint(equalToConstant: 18),
            
            typeOfFoodImage.heightAnchor.constraint(equalToConstant: 16),
            typeOfFoodImage.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}
