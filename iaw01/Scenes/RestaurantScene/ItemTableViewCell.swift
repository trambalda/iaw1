import UIKit

final class ItemTableViewCell: UITableViewCell {
    static let identifier = "ItemTableViewCell"
    
    var model: MenuItemListModel = .empty {
        didSet {
            foodImage.image = model.foodImage
            nameLabel.attributedText = Font.body.compose(model.foodTitle)
            oldPriceLabel.attributedText = Font.body.compose(model.oldPrice)    //change font
            newPriceLabel.attributedText = Font.body.compose(model.newPrice)    //change font
        }
    }
    
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
    
    private let nameLabel = UILabel()
    private let oldPriceLabel = UILabel()
    private let newPriceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutAndConstraints() {
        let priceStack = UIStackView(arrangedSubviews: [oldPriceLabel, newPriceLabel])
        priceStack.spacing = 9
        
        let infoStack = UIStackView(arrangedSubviews: [nameLabel, priceStack])
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.spacing = 1
        
        let itemStack = UIStackView(arrangedSubviews: [foodImage, infoStack])
        itemStack.spacing = 10
        
        let mainStack = UIStackView(arrangedSubviews: [itemStack, arrowImage])
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            foodImage.widthAnchor.constraint(equalToConstant: 98),
            foodImage.heightAnchor.constraint(equalToConstant: 41),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
