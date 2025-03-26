import UIKit

final class NavigationBarView: UIView {
    private let backLabel: UILabel = {
        let label = UILabel()
        label.text = "Back"
        label.font = Font.backButton.font
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrowLeft, for: .normal)
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(.more, for: .normal)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(.search, for: .normal)
        return button
    }()
    
    private let shoppingBagButton: UIButton = {
        let button = UIButton()
        button.setImage(.shoppingBag, for: .normal)
        return button
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutAndConstraints() {
        let backButtonStack = UIStackView()
        backButtonStack.spacing = 1
        backButtonStack.alignment = .center
        backButtonStack.translatesAutoresizingMaskIntoConstraints = false
        backButtonStack.addArrangedSubview(backButton)
        backButtonStack.addArrangedSubview(backLabel)
        
        let actionsButtonStack = UIStackView()
        actionsButtonStack.spacing = 16
        actionsButtonStack.alignment = .center
        actionsButtonStack.translatesAutoresizingMaskIntoConstraints = false
        actionsButtonStack.addArrangedSubview(moreButton)
        actionsButtonStack.addArrangedSubview(searchButton)
        actionsButtonStack.addArrangedSubview(shoppingBagButton)
        
        addSubview(backButtonStack)
        addSubview(actionsButtonStack)
        
        NSLayoutConstraint.activate([
            backButtonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            backButtonStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            actionsButtonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            actionsButtonStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

