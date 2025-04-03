import UIKit

final class ItemTableViewCell: UITableViewCell {
    var model: MenuItemListModel = .empty {
        didSet {
            foodImage.image = model.foodImage ?? UIImage(systemName: "photo")
            nameLabel.text = model.foodTitle ?? "No title"
            oldPriceLabel.text = model.oldPrice ?? ""
            newPriceLabel.text = model.newPrice ?? "No price"
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
    }()
    
    // Исправить потом шрифт
    private let oldPriceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
    }()
    
    // Исправить потом шрифт
    private let newPriceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
    }()
    
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
