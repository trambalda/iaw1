import UIKit

class MealImageView: UIView {

    private lazy var mealImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 1
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var burgherImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .burgher))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 2
        return image
    }()
    
    private lazy var friesImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .frenchFries))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 1
        return image
    }()
    
    private lazy var drinkImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .drink))
        image.contentMode = .scaleAspectFit
        image.layer.zPosition = 3
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
        addSubview(mealImageStackView)
        mealImageStackView.addArrangedSubview(burgherImage)
        mealImageStackView.addArrangedSubview(friesImage)
        mealImageStackView.addArrangedSubview(drinkImage)
        
        mealImageStackView.setCustomSpacing(-20, after: burgherImage)
        mealImageStackView.setCustomSpacing(-20, after: friesImage)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mealImageStackView.heightAnchor.constraint(equalToConstant: 198),
            mealImageStackView.widthAnchor.constraint(equalToConstant: 438),
            mealImageStackView.topAnchor.constraint(equalTo: topAnchor),
            mealImageStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mealImageStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mealImageStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
