import UIKit

final class DishHeaderView: UIStackView {
    
    var model: DishModel = .empty {
        didSet {
            imageView.image = model.image ?? UIImage(systemName: "photo")
            titleLabel.attributedText = Font.heading4.compose(model.name.isEmpty ? "Название блюда" : model.name)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.dark60,
                .font: Font.caption.font
            ]
            
            caloriesLabel.attributedText = NSAttributedString(
                string: model.calories.isEmpty ? "Количество калорий" : model.calories, attributes: attributes)     //проверить и поменять шрифт
        }
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dark60
        return label
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.infoCircle, for: .normal)
        button.tintColor = .dark60
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        spacing = 6
        alignment = .leading
        
        setupLayout()
        setupConstraints()
    }
    
    /*
     imageView
     titleLabel
     infoStackView
        caloriesLabel
        infoButton
     */
    
    private func setupLayout() {
        let infoStackView = UIStackView()
        infoStackView.spacing = 4
        
        addArrangedSubview(imageView)
        addArrangedSubview(titleLabel)
        addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(caloriesLabel)
        infoStackView.addArrangedSubview(infoButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 202)
        ])
    }
}
