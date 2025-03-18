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
    
    private let style: CornerButtonStyle
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = Font.button
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var alphaWhenTouch: CGFloat {
        isEnabled ? 1.0 : 0.6
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
            self.alpha = self.alphaWhenTouch
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = self.alphaWhenTouch
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    func setTitle(_ title: String) {
        buttonLabel.text = title
    }
    
    func setIcon(_ icon: ButtonIcon?, position: IconPosition = .right) {
        if let icon {
            let image = icon.image
            leftIconImageView.image = image
            rightIconImageView.image = image
            
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
        layer.cornerRadius = 18
        
        setupStackView()
        setupTitleLabel()
        setupConstraints()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftIconImageView)
        stackView.addArrangedSubview(buttonLabel)
        stackView.addArrangedSubview(rightIconImageView)
    }
    
    private func setupTitleLabel() {
        buttonLabel.textColor = style.textColor
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
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
    
    init(style: CornerButtonStyle = .blue) {
        self.style = style
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 