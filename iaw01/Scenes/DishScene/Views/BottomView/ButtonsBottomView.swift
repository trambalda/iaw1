import UIKit

final class ButtonsBottomView: UIView {
    
    private let favoriteButtonSize: CGFloat = 62
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .dark60
        button.setImage(.bagHeart, for: .normal)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let addToBagButton = AddToBagButton()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 18
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutAndConstraints() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(favoriteButton)
        contentStackView.addArrangedSubview(addToBagButton)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonSize)
        ])
    }
}
