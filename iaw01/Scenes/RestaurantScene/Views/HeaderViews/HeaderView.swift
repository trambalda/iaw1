import UIKit

final class HeaderView: UIStackView {
    
    var imageService: ImageServiceProtocol?
    
    var model: RestaurantModel = .empty {
        didSet {
            loadImage(from: model.imageURL)
            restaurantHeaderView.imageService = imageService
            restaurantHeaderView.model = model
            restaurantInfoView.model = model
        }
    }
    
    private let restaurantHeaderView = RestaurantHeaderView()
    private let restaurantInfoView = RestaurantInfoView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let restaurantInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let restaurantInfoContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        adjustForSmallScreens()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage(from url: URL?) {
        guard let url else { return }
        
        Task {
            do {
                let image = try await imageService?.loadImage(from: url)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } catch {
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
    /*
     imageView
     restaurantInfoContainer
        restaurantInfoStack
            restaurantHeaderView
            restaurantInfoView
     */
    
    private func configure() {
        axis = .vertical
        
        setupLayout()
        setupConstraints()
    }
   
    private func setupLayout() {
        addArrangedSubview(imageView)
        addArrangedSubview(restaurantInfoContainer)
        
        restaurantInfoContainer.addSubview(restaurantInfoStackView)
        
        restaurantInfoStackView.addArrangedSubview(restaurantHeaderView)
        restaurantInfoStackView.addArrangedSubview(restaurantInfoView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            restaurantInfoStackView.topAnchor.constraint(equalTo: restaurantInfoContainer.topAnchor, constant: 20),
            restaurantInfoStackView.leadingAnchor.constraint(equalTo: restaurantInfoContainer.leadingAnchor,constant: 16),
            restaurantInfoStackView.trailingAnchor.constraint(equalTo: restaurantInfoContainer.trailingAnchor, constant: -16),
            restaurantInfoStackView.bottomAnchor.constraint(equalTo: restaurantInfoContainer.bottomAnchor),
        ])
    }
    
    private func adjustForSmallScreens() {
        guard Constants.isSE else { return }
    }
}

