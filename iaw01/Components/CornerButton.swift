import UIKit

struct CornerButtonStyle {
    var backgroundColor: UIColor
    var disabledBackgroundColor: UIColor
    var textColor: UIColor
    var icon: CornersButton.ButtonIcon?
    var iconPosition: CornersButton.IconPosition
    
    static let blue = CornerButtonStyle(
        backgroundColor: UIColor(resource: .blue100),
        disabledBackgroundColor: UIColor(resource: .blue60),
        textColor: UIColor(resource: .light100),
        icon: nil,
        iconPosition: .right
    )
    
    static let pink = CornerButtonStyle(
        backgroundColor: UIColor(resource: .pink100),
        disabledBackgroundColor: UIColor(resource: .pink60),
        textColor: UIColor(resource: .light100),
        icon: nil,
        iconPosition: .right
    )
    
    static let dark = CornerButtonStyle(
        backgroundColor: UIColor(resource: .dark100),
        disabledBackgroundColor: UIColor(resource: .dark60),
        textColor: UIColor(resource: .light100),
        icon: nil,
        iconPosition: .right
    )
    
    static let light = CornerButtonStyle(
        backgroundColor: UIColor(resource: .light100),
        disabledBackgroundColor: UIColor(resource: .light80),
        textColor: UIColor(resource: .dark90),
        icon: nil,
        iconPosition: .right
    )
}

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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .fill
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let style: CornerButtonStyle
    
    private var alphaWhenTouch: CGFloat {
        isEnabled ? 1.0 : 0.6
    }
    
    init(
        style: CornerButtonStyle = .blue,
        isEnabled: Bool = true
    ) {
        self.style = style
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButton(style: style)
        self.isEnabled = isEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(
        style: CornerButtonStyle
    ) {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 18
        
        setupStackView()
        setupTitleLabel(style: style)
        setupConstraints()
    }

    private func setupStackView() {
        addSubview(stackView)
    }
    
    private func setupTitleLabel(
        style: CornerButtonStyle
    ) {
        buttonLabel.textColor = style.textColor
        stackView.addArrangedSubview(buttonLabel)
    }
    
    private func setupIcon(
        icon: ButtonIcon,
        style: CornerButtonStyle,
        position: IconPosition
    ) {
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
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setTitle(_ title: String) {
        buttonLabel.text = title
    }
    
    func setIcon(
        _ icon: ButtonIcon?,
        position: IconPosition = .right
    ) {
        if let icon {
            iconImageView.image = icon.image
            iconImageView.tintColor = style.textColor
            iconImageView.isHidden = false
            
            iconImageView.removeFromSuperview()
            
            switch position {
            case .left:
                stackView.insertArrangedSubview(iconImageView, at: 0)
            case .right:
                stackView.addArrangedSubview(iconImageView)
            }
        } else {
            iconImageView.image = nil
            iconImageView.isHidden = true
            iconImageView.removeFromSuperview()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.7
        }
    }
    
    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.alphaWhenTouch
        }
    }
    
    override func touchesCancelled(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.alphaWhenTouch
        }
    }
    
    private func updateAppearance() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        alpha = alphaWhenTouch
    }
}
