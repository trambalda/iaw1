import UIKit

class CornersButton: UIButton {
    enum ButtonIcon {
        case checkmarkCircle
        case gps
        case arrowRight
        
        var image: UIImage? {
            switch self {
            case .checkmarkCircle: return UIImage(resource: .tickCircle)
            case .gps: return UIImage(resource: .gps)
            case .arrowRight: return UIImage(resource: .rightChevron)
            }
        }
    }
    
    enum IconPosition {
        case left
        case right
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
    
    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.textColor = style.textColor
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = iconImageView
        configureIconImageView(imageView)
        return imageView
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = iconImageView
        configureIconImageView(imageView)
        return imageView
    }()
    
    private var iconImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }
    
    private var alphaWhenTouch: CGFloat {
        isEnabled ? 1.0 : 0.6
    }
    
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
    
    init(style: CornersButtonStyle = .blue) {
        self.style = style
        super.init(frame: .zero)
        
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        setupConstraints()
    }
    
    convenience init(
        style: CornersButtonStyle = .blue,
        title: String,
        icon: ButtonIcon? = nil,
        position: IconPosition = .right,
        target: Any? = nil,
        action: Selector? = nil
    ) {
        self.init(style: style)
        setTitle(title)
        if let icon {
            setIcon(icon, position: position)
        }
        if let target, let action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureIconImageView(_ imageView: UIImageView) {
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setupButton() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
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
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        alpha = alphaWhenTouch
    }
    
    func setTitle(_ title: String) {
        buttonLabel.text = title
    }
    
    func setIcon(_ icon: ButtonIcon?, position: IconPosition = .right) {
        if let icon {
            leftIconImageView.image = icon.image
            rightIconImageView.image = icon.image
            
            leftIconImageView.tintColor = style.textColor
            rightIconImageView.tintColor = style.textColor
            
            leftIconImageView.isHidden = position == .right
            rightIconImageView.isHidden = position == .left
        } else {
            leftIconImageView.isHidden = true
            rightIconImageView.isHidden = true
        }
    }
} 