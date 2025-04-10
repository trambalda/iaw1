import UIKit

class MealImageView: UIView {
    
    private lazy var mealImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .meal))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
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
        addSubview(mealImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 198),
            widthAnchor.constraint(equalToConstant: 428),
            
            mealImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            mealImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
