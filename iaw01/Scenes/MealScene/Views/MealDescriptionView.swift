import UIKit

class MealDescriptionView: UIView {
    
    private lazy var mealImageView = MealImageView()
    
    private lazy var mealStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let newCodeOuterStackView = UIStackView()
        newCodeOuterStackView.axis = .vertical
        newCodeOuterStackView.alignment = .leading
        
        mealCaloriesStackView.addArrangedSubview(mealCaloriesLabel)
        mealCaloriesStackView.addArrangedSubview(mealCaloriesImage)
        
        mealStackView.addArrangedSubview(mealImageView)
        mealStackView.addArrangedSubview(mealNameLabel)
        mealStackView.addArrangedSubview(newCodeOuterStackView)
        newCodeOuterStackView.addArrangedSubview(mealCaloriesStackView)
        
        addSubview(mealStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mealStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            mealStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mealStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}
