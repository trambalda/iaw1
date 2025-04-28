import UIKit

class CornersButton: UIButton {    

    enum IconPosition {
        case left
        case right
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    private let style: CornersButtonStyle
    var onTap: (() -> Void)?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private let buttonLabel = UILabel()
    
    private var iconImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }
    
    private lazy var leftIconImageView = iconImageView
    private lazy var rightIconImageView = iconImageView
    
    init(style: CornersButtonStyle = .nextButton) {
        self.style = style
        super.init(frame: .zero)
        
        setupButton()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        buttonLabel.attributedText = Font.button.compose(title, color: style.textColor)
    }
    
    func setIcon(_ icon: UIImage?, position: IconPosition = .right) {
        if let icon {
            leftIconImageView.image = icon
            rightIconImageView.image = icon
            
            leftIconImageView.tintColor = style.textColor
            rightIconImageView.tintColor = style.textColor
            
            leftIconImageView.isHidden = position == .right
            rightIconImageView.isHidden = position == .left
        } else {
            leftIconImageView.isHidden = true
            rightIconImageView.isHidden = true
        }
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
    
    private func setupButton() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
        
        if let title = style.title {
            setTitle(title)
        }
        
        if let icon = style.icon {
            setIcon(icon, position: style.iconPosition)
        } 

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftIconImageView)
        stackView.addArrangedSubview(buttonLabel)
        stackView.addArrangedSubview(rightIconImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            heightAnchor.constraint(equalToConstant: 64),
            
            leftIconImageView.widthAnchor.constraint(equalToConstant: 24),
            rightIconImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
    }
} 
