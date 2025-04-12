import UIKit

class QuantityCalcButtons: UIView {
    
    private let quantityCalculator = QuantityCalculator()
    
    private var currentQuantity = 1
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        return stack
    }()
    
    private lazy var minusButton: CustomCircleButton = {
        let button = CustomCircleButton()
        button.configureButtonWith(image: UIImage(resource: .minusButton), shouldHighlight: true) { [weak self] in
            guard let self = self else { return }
            
            self.quantityLabel.text = String(self.quantityCalculator.decreaseQuantity(currentQuantity: currentQuantity))
        }
        return button
    }()
    
    private lazy var plusButton: CustomCircleButton = {
        let button = CustomCircleButton()
        button.configureButtonWith(image: UIImage(resource: .plusButton), shouldHighlight: true) { [weak self] in
            guard let self = self else { return }
            
            self.quantityLabel.text = String(self.quantityCalculator.increaseQuantity(currentQuantity: currentQuantity))
        }
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = String(currentQuantity)
        return label
    }()
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(plusButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
