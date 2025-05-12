import UIKit

final class RestaurantHeaderView: UIStackView {
    
    var imageService: ImageServiceProtocol?
    
    var model: RestaurantModel = .empty {
        didSet {
            loadImage(from: model.logoURL)
            titleLabel.attributedText = Font.name.compose(model.name)
            locationLabel.attributedText = Font.body.compose(model.address)
        }
    }
    
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let locationImageView: UIImageView = {
        let image = UIImageView(image: .location)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let favoriteButtonSize: CGFloat = 50
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .light80
        button.layer.cornerRadius = favoriteButtonSize / 2
        button.setImage(.heart, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
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
                    self.logoImageView.image = image
                }
            } catch {
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
   
    private func configure() {
        spacing = 8
        alignment = .center
        
        setupLayout()
        setupConstraints()
    }
    
    /*
     logoImageView
        infoStack
            titleLabel
            locationStack
                locationImage
                locationLabel
     favoriteButton
     */
    
    private func setupLayout() {
        let locationStackView = UIStackView()
        locationStackView.spacing = 4
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 0
       
        addArrangedSubview(logoImageView)
        setCustomSpacing(16, after: logoImageView)
        addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(locationStackView)
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(locationLabel)
        addArrangedSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 64),
            logoImageView.heightAnchor.constraint(equalToConstant: 64),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonSize)
        ])
    }
}
