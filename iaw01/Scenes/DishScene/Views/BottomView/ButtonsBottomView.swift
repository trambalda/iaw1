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
    
    private let stackView: UIStackView = {
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
        addSubview(stackView)
        stackView.addArrangedSubview(favoriteButton)
        stackView.addArrangedSubview(addToBagButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: favoriteButtonSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: favoriteButtonSize)
        ])
    }
}
