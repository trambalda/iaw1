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
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(toggleOpen), for: .touchUpInside)
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
            let buttonName = isOpened ? "minus.circle.fill" : "plus.circle.fill"
            openButton.setImage(UIImage(systemName: buttonName), for: .normal)
        }
    }
    
    private var drinkCategory: DrinkCategory?
    
    init(title: String, isRequired: Bool, category: DrinkCategory?) {
        super.init(frame: .zero)
        self.drinkCategory = category
        configure(title: title, isRequired: isRequired)
        
        if let category = category {
            populateOptions(for: category)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String, isRequired: Bool) {
        backgroundColor = .light80
        titleLabel.text = title
        requiredLabel.text = isRequired ? "REQUIRED" : ""
       
        setupLayoutAndConstraints()
    }
    
    private func populateOptions(for category: DrinkCategory) {
        if let subcategories = category.subcategories {
            for subcategory in subcategories {
                let optionLabel = UILabel()
                optionLabel.text = subcategory.name
                contentStackView.addArrangedSubview(optionLabel)
                
                if let options = subcategory.options {
                    for option in options {
                        let optionLabel = UILabel()
                        optionLabel.text = "\(option)"
                        contentStackView.addArrangedSubview(optionLabel)
                    
                    }
                }
            }
        } else if let options = category.options {
            for option in options {
                let optionLabel = UILabel()
                optionLabel.text = "\(option)"
                contentStackView.addArrangedSubview(optionLabel)
            }
        }
    }
    /*
     mainStackView
        headerStackView
            titleLabel
            rightStackView
                requiredLabel
                openButton
        contentStackView
     */
    private func setupLayoutAndConstraints() {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5       //точно ли?
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightStackView = UIStackView()
        rightStackView.alignment = .center
        rightStackView.setContentHuggingPriority(.required, for: .horizontal)
        
        let headerStackView = UIStackView()
        headerStackView.alignment = .center
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerStackView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(rightStackView)
        rightStackView.addArrangedSubview(requiredLabel)
        rightStackView.addArrangedSubview(openButton)
        rightStackView.setCustomSpacing(14, after: requiredLabel)
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
