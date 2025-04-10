import UIKit

class AuthorizationSocialButtonsView: UIStackView {
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Or Login Using:", color: .dark80)
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .light60
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    private let separatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private func createButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        return button
    }
    
    private lazy var googleButton = createButton(imageName: "googleLogo")
    private lazy var appleButton = createButton(imageName: "appleLogo")
    
    private lazy var socialButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .vertical
        alignment = .leading
        distribution = .equalSpacing
        setupLayout()
        setupConstraints()
        setupActions()
    }
    
    private func setupLayout() {
        separatorStackView.addArrangedSubview(separatorLabel)
        separatorStackView.addArrangedSubview(separatorLineView)
        addArrangedSubview(separatorStackView)
        socialButtonStackView.addArrangedSubview(googleButton)
        socialButtonStackView.addArrangedSubview(appleButton)
        addArrangedSubview(socialButtonStackView)
        
        setCustomSpacing(28, after: separatorStackView)
    }
    
    private func setupActions() {
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
    }
    
    @objc private func didTapGoogleButton() {
        if let url = URL(string: "https://accounts.google.com/InteractiveLogin") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func didTapAppleButton() {
        if let url = URL(string: "https://account.apple.com") {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            separatorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            googleButton.widthAnchor.constraint(equalToConstant: 71),
            googleButton.heightAnchor.constraint(equalToConstant: 71),
            appleButton.widthAnchor.constraint(equalToConstant: 71),
            appleButton.heightAnchor.constraint(equalToConstant: 71),
        ])
    }
}
