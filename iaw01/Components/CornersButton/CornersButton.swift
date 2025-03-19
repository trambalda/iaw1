import UIKit

class CornersButton: UIButton {    
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : self.alphaWhenTouch
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private let style: CornersButtonStyle
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private let buttonLabel = UILabel()
    
    private func CreateIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }
    
    private lazy var leftIconImageView = CreateIconImageView()
    private lazy var rightIconImageView = CreateIconImageView()
    
    private var alphaWhenTouch: CGFloat {
        isEnabled ? 1.0 : 0.6
    }
    
    init(style: CornersButtonStyle = .blue) {
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
    
    private func setupButton() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        
        if let title = style.title {
            setTitle(title)
        }
        
        if let icon = style.icon {
            setIcon(icon, position: style.iconPosition)
        } 
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
        alpha = alphaWhenTouch
    }
} 
