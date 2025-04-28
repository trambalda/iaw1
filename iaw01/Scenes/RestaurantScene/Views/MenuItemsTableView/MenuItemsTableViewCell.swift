import UIKit

final class MenuItemsTableViewCell: UITableViewCell {
    
    static let identifier = "MenuItemsTableViewCell"
    static let cellHeight: CGFloat = 100
    
    var imageService: ImageServiceProtocol?
    
    var model: MenuItemListModel = .empty {
        didSet {
            loadImage(from: model.imageURL)
            nameLabel.attributedText = Font.body.compose(model.name)
            priceLabel.attributedText = Font.body.compose(String(format: "%.2f", model.price))
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceLabel = UILabel()
    private let arrowImageView = UIImageView(image: .arrowRight)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(from url: URL?) {
        guard let url else { return }
        
        Task {
            do {
                let image = try await imageService?.loadImage(from: url)
                DispatchQueue.main.async {
                    self.foodImageView.image = image
                }
            } catch {
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
    
    private func configure() {
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
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.spacing = 1
        
        let itemStackView = UIStackView()
        itemStackView.spacing = 10
        itemStackView.alignment = .center
        
        let mainStackView = UIStackView()
        mainStackView.spacing = 10
        mainStackView.alignment = .center
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(itemStackView)
        itemStackView.addArrangedSubview(foodImageView)
        itemStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(priceLabel)
        
        mainStackView.addArrangedSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            foodImageView.widthAnchor.constraint(equalToConstant: 96),
            foodImageView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
