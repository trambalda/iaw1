import UIKit

protocol DishOptionViewDelegate: AnyObject {
    func didSelectDrinkCategory(_ category: DrinkCategory)
}

final class DishOptionView: UIView {
    
    weak var delegate: DishOptionViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body.font     //поменять
        return label
    }()
    
    private let requiredLabel: UILabel = {
        let label = UILabel()
        label.font = Font.caption.font     //поменять
        label.textColor = .systemGreen100
        return label
    }()
    
    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .dark60
        button.setImage(.plus, for: .normal)
        button.addTarget(DishOptionView.self, action: #selector(toggleOpen), for: .touchUpInside)
        return button
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isHidden = true
        return stackView
    }()
    
    private var isOpened = false {
        didSet {
            contentStackView.isHidden = !isOpened
            let buttonName = isOpened ? "minus" : "plus"
            openButton.setImage(UIImage(systemName: buttonName), for: .normal)
        }
    }
    
    private var drinkCategory: DrinkCategory?
    
    init(title: String, isRequired: Bool, category: DrinkCategory? = nil) {
        super.init(frame: .zero)
        
        configure(title: title, isRequired: isRequired, category: category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String, isRequired: Bool, category: DrinkCategory?) {
        titleLabel.text = title
        requiredLabel.text = isRequired ? "REQUIRED" : ""
       
        if let category = category {
            drinkCategory = category
            category.options.forEach { option in
                let optionLabel = UILabel()
                optionLabel.text = option
                contentStackView.addArrangedSubview(optionLabel)
            }
        }
        
        setupLayoutAndConstraints()
    }
    
    private func setupLayoutAndConstraints() {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5       //точно ли?
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerStackView = UIStackView()
        headerStackView.alignment = .center
        headerStackView.distribution = .fillProportionally
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(requiredLabel)
        headerStackView.addArrangedSubview(openButton)
        mainStackView.addArrangedSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func toggleOpen() {
        isOpened.toggle()
    }
}
