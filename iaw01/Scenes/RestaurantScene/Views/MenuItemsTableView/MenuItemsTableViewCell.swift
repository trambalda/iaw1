import UIKit

final class MenuItemsTableViewCell: UITableViewCell {
    
    static let identifier = "MenuItemsTableViewCell"
    
    var model: MenuItemListModel = .empty {
        didSet {
            foodImage.image = model.foodImage
            nameLabel.attributedText = Font.body.compose(model.foodTitle)
            oldPriceLabel.attributedText = Font.body.compose("$\(model.oldPrice)")    //change font
            newPriceLabel.attributedText = Font.body.compose("$\(model.newPrice)")    //change font
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView(image: .arrowRight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //private let nameLabel = UILabel()
    private let oldPriceLabel = UILabel()
    private let newPriceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     mainStack
        itemStack
            foodImage
            infoStack
                nameLabel
                priceStack
                    oldPriceLabel
                    newPriceLabel
        arrowImage
     */
    
    private func setupLayoutAndConstraints() {
        let priceStack = UIStackView()
        priceStack.spacing = 9
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.spacing = 1
        
        let itemStack = UIStackView()
        itemStack.spacing = 10
        
        let mainStack = UIStackView()
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(itemStack)
        itemStack.addArrangedSubview(foodImage)
        itemStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(priceStack)
        priceStack.addArrangedSubview(oldPriceLabel)
        priceStack.addArrangedSubview(newPriceLabel)
        mainStack.addArrangedSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            foodImage.widthAnchor.constraint(equalToConstant: 98),
            foodImage.heightAnchor.constraint(equalToConstant: 41),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
