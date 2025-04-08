import UIKit

class MealDescriptionView: UIView {
    
    private lazy var mealStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mealImageView: MealImageView = {
        let view = MealImageView()
        return view
    }()
    
    private lazy var mealNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Western BBQ Cheeseburger Meal", color: .dark100)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mealCaloriesLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.note.compose("340-400 Cals", color: .dark60)
        return label
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
        mealStackView.addArrangedSubview(mealImageView)
        mealStackView.addArrangedSubview(mealNameLabel)
        mealStackView.addArrangedSubview(mealCaloriesLabel)
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
