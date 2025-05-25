import UIKit

final class NewAndTrendingViewCell: UICollectionViewCell {
    static let cellIdentifier = "NewAndTrendingViewCell"
    
    var imageService: ImageServiceProtocol?
    
    var model: NewAndTrendingModel = .empty {
        didSet {
            foodImageView.image = placeholderPhotoImage
            restaurantLogoImageView.image = placeholderPhotoImage
            loadImage(for: foodImageView,
                      from: model.foodImageURL,
                      originalURLFromModel: model.foodImageURL
            )
            loadImage(for: restaurantLogoImageView,
                      from: model.restaurantImageURL,
                      originalURLFromModel: model.restaurantImageURL
            )
            restaurantNameLabel.attributedText = Font.segment.compose(model.restaurantTitle, color: .dark100)
            distanceLabel.attributedText = Font.note.compose(model.distance, color: .dark80)
        }
    }
    
    private let placeholderPhotoImage = UIImage(named: "restaurant")
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let restaurantLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private let restaurantNameLabel = UILabel()
    
    private let distanceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(for imageView: UIImageView, from urlToLoad: URL?, originalURLFromModel: URL?) {
        guard let currentUrlToLoad = urlToLoad, let imageService = imageService else {
            imageView.image = placeholderPhotoImage
            return
        }
        
        Task {
            do {
                let image = try await imageService.loadImage(from: currentUrlToLoad)
                if originalURLFromModel == currentUrlToLoad {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    print("Image loading cancelled for \(currentUrlToLoad) due to cell reuse.")
                }
            } catch {
                print("Ошибка загрузки изображения для URL (\(currentUrlToLoad)): \(error)")
                DispatchQueue.main.async {
                    if imageView.image == UIImage() {
                        imageView.image = self.placeholderPhotoImage
                    }
                }
            }
        }
    }
    
    private func setupLayoutAndConstraints() {
        addSubview(foodImageView)
        addSubview(restaurantLogoImageView)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(restaurantNameLabel)
        infoStackView.addArrangedSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 114),
            
            restaurantLogoImageView.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8),
            restaurantLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantLogoImageView.heightAnchor.constraint(equalToConstant: 36),
            restaurantLogoImageView.widthAnchor.constraint(equalToConstant: 36),
            
            infoStackView.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8),
            infoStackView.leadingAnchor.constraint(equalTo: restaurantLogoImageView.trailingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
