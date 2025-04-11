import UIKit

class SideItemExpandedView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mediumFries: Additionals = {
        let fries = Additionals(
            itemImage: UIImage(resource: .mediumFries),
            itemTitle: "Medium Fries",
            type: .select)
        return fries
    }()
    
    private lazy var largeFries: Additionals = {
        let fries = Additionals(
            itemImage: UIImage(resource: .largeFries),
            itemTitle: "Large Fries",
            type: .select)
        return fries
    }()
    
    private lazy var mediumFriesImage: UIImageView = {
        let image = UIImageView(image: mediumFries.itemImage)
        return image
    }()
    
    private lazy var largeFriesImage: UIImageView = {
        let image = UIImageView(image: largeFries.itemImage)
        return image
    }()
    
    private lazy var mediumFriesLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose(mediumFries.itemTitle)
        return label
    }()
    
    private lazy var largeFriesLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose(largeFries.itemTitle)
        return label
    }()
    
    func setupLayoutAndConstraints() {
        let mediumFriesStackView = UIStackView()
        mediumFriesStackView.spacing = 2
        let largeFriesStackView = UIStackView()
        largeFriesStackView.spacing = 2
        
        addSubview(stackView)
        stackView.addArrangedSubview(mediumFriesStackView)
        stackView.addArrangedSubview(largeFriesStackView)
        
        mediumFriesStackView.addArrangedSubview(mediumFriesImage)
        mediumFriesStackView.addArrangedSubview(mediumFriesLabel)
        largeFriesStackView.addArrangedSubview(largeFriesImage)
        largeFriesStackView.addArrangedSubview(largeFriesLabel)
        
        NSLayoutConstraint.activate([
            mediumFriesStackView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 14.5),
            mediumFriesStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 21),
            mediumFriesStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -21),
            mediumFriesStackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -14.5)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
