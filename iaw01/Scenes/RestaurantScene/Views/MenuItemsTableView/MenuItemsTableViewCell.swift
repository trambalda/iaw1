import UIKit

final class MenuItemsTableViewCell: UITableViewCell {
    
    static let identifier = "MenuItemsTableViewCell"
    static let cellHeight: CGFloat = 100
    
    var model: MenuItemListModel = .empty {
        didSet {
            foodImage.image = UIImage(named: model.image)
            nameLabel.attributedText = Font.body.compose(model.name)
            priceLabel.attributedText = Font.body.compose(String(format: "%.2f", model.price))
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceLabel = UILabel()
    private let arrowImage = UIImageView(image: .arrowRight)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        separatorInset = .zero
    }
    
    /*
     mainStack
        itemStack
            foodImage
            infoStack
                nameLabel
                priceLabel
        arrowImage
     */
    
    private func setupLayoutAndConstraints() {
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.spacing = 1
        
        let itemStack = UIStackView()
        itemStack.spacing = 10
        itemStack.alignment = .center
        
        let mainStack = UIStackView()
        mainStack.spacing = 10
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(itemStack)
        itemStack.addArrangedSubview(foodImage)
        itemStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(priceLabel)
        
        mainStack.addArrangedSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            foodImage.widthAnchor.constraint(equalToConstant: 96),
            foodImage.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
