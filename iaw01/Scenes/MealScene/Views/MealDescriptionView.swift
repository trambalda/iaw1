import UIKit

class MealDescriptionView: UIStackView {
    
    private lazy var mealImageView = MealImageView()
    
    private lazy var mealNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Western BBQ Cheeseburger Meal", color: .dark100)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    private var mealCaloriesStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        return stack
    }()
    
    private lazy var mealCaloriesLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.note.compose("340-400 Cals", color: .dark60)
        return label
    }()
    
    private lazy var mealCaloriesImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .infoCircle))
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 6
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let newCodeOuterStackView = UIStackView()
        newCodeOuterStackView.axis = .vertical
        newCodeOuterStackView.alignment = .leading
        
        addArrangedSubview(mealImageView)
        newCodeOuterStackView.addArrangedSubview(mealNameLabel)
        newCodeOuterStackView.addArrangedSubview(mealCaloriesStackView)
        
        mealCaloriesStackView.addArrangedSubview(mealCaloriesLabel)
        mealCaloriesStackView.addArrangedSubview(mealCaloriesImage)
        
        addArrangedSubview(newCodeOuterStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mealCaloriesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
    }
}
