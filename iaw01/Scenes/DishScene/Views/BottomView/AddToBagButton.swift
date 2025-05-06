import UIKit

final class AddToBagButton: UIControl {
    
    private let bagImageView: UIImageView = {
        let imageView = UIImageView(image: .happyBag)
        imageView.tintColor = .light100
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add to Bag"
        label.textColor = .light100
        label.font = Font.button.font
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button.font       //change
        label.text = "$6.69"
        label.textColor = .blue100
        label.textAlignment = .right
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 7
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .dark100
        layer.cornerRadius = 18
        clipsToBounds = true
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(bagImageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 62),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
