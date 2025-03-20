import UIKit

final class DishTableViewCell: UITableViewCell {
    var model: DishCellModel = .empty {
        didSet {
            nameLabel.text = model.foodTitle
            dishImage.image = model.foodImage ?? noPhotoImage
            restaurantImage.image = model.restaurantImage ?? noPhotoImage
            restaurantLabel.text = model.restaurantTitle
        }
    }
    
    private let cellImageView: UIImageView = {
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
    
    private let noPhotoImage = UIImage(systemName: "photo")
    
    private let restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = Font.note.font
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font
        return label
    }()
    
    private lazy var dishImage = cellImageView
     
    private lazy var restaurantImage = cellImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutAndConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     mainStack
        dishImage
        infoStack
            nameLabel
            restaurantStack
                restaurantImage
                restaurantLabel
        arrowImage
     */
    
    private func setupLayoutAndConstraints() {
        let restaurantStack = UIStackView()
        restaurantStack.spacing = 5
        restaurantStack.alignment = .center
        restaurantStack.addArrangedSubview(restaurantImage)
        restaurantStack.addArrangedSubview(restaurantLabel)
    
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 3
        infoStack.alignment = .leading
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(restaurantStack)
        
        let mainStack = UIStackView()
        mainStack.spacing = 9
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(dishImage)
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(arrowImage)
        
        contentView.addSubview(mainStack)
       
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dishImage.widthAnchor.constraint(equalToConstant: 106),
            dishImage.heightAnchor.constraint(equalToConstant: 49),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 21),
            restaurantImage.heightAnchor.constraint(equalToConstant: 21),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
