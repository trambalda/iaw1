import UIKit

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

enum ButtonStyle {
    case blue
    case pink
    case dark
    case light

    var backgroundColor: UIColor {
        switch self {
        case .blue: return UIColor(resource: .blue100)
        case .pink: return UIColor(resource: .pink100)
        case .dark: return UIColor(resource: .dark100)
        case .light: return UIColor(resource: .light100)
        }
    }
    
    var disabledBackgroundColor: UIColor {
        switch self {
        case .blue: return UIColor(resource: .blue60)
        case .pink: return UIColor(resource: .pink60)
        case .dark: return UIColor(resource: .dark60)
        case .light: return UIColor(resource: .light80)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light: return UIColor(resource: .dark90)
        default: return UIColor(resource: .light100)
        }
    }
}

enum IconPosition {
    case left
    case right
}

class MainButton: UIButton {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var currentStyle: ButtonStyle = .blue
    
    init(style: ButtonStyle = .blue,
         title: String,
         icon: ButtonIcon? = nil,
         iconPosition: IconPosition = .right,
         isEnabled: Bool = true) {
        super.init(frame: .zero)
        self.currentStyle = style
        setupButton(style: style, title: title, icon: icon, iconPosition: iconPosition)
        self.isEnabled = isEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(style: ButtonStyle,
                           title: String,
                           icon: ButtonIcon?,
                           iconPosition: IconPosition) {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
        
        setupStackView()
        setupTitleLabel(title: title, style: style)
        
        if let icon = icon {
            setupIcon(icon: icon, style: style, position: iconPosition)
        }
        
        setupConstraints()
    }

    private func setupStackView() {
        addSubview(stackView)
    }
    
    private func setupTitleLabel(title: String, style: ButtonStyle) {
        buttonLabel.text = title
        buttonLabel.textColor = style.textColor
        stackView.addArrangedSubview(buttonLabel)
    }
    
    private func setupIcon(icon: ButtonIcon, style: ButtonStyle, position: IconPosition) {
        iconImageView.image = icon.image
        iconImageView.tintColor = style.textColor
        iconImageView.contentMode = .scaleAspectFit
        
        switch position {
        case .left:
            stackView.insertArrangedSubview(iconImageView, at: 0)
        case .right:
            stackView.addArrangedSubview(iconImageView)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setTitle(_ title: String) {
        buttonLabel.text = title
    }
    
    func setIcon(_ icon: ButtonIcon?, position: IconPosition = .left) {
        iconImageView.image = icon?.image
        iconImageView.tintColor = currentStyle.textColor
        iconImageView.isHidden = icon == nil
        
        if icon != nil {
            iconImageView.removeFromSuperview()
            
            switch position {
            case .left:
                stackView.insertArrangedSubview(iconImageView, at: 0)
            case .right:
                stackView.addArrangedSubview(iconImageView)
            }
        }
    }
    
    func setStyle(_ style: ButtonStyle) {
        currentStyle = style
        updateAppearance()
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.7
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.isEnabled ? 1.0 : 0.6
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.isEnabled ? 1.0 : 0.6
        }
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? currentStyle.backgroundColor : currentStyle.disabledBackgroundColor
        alpha = isEnabled ? 1.0 : 0.6
    }
}
