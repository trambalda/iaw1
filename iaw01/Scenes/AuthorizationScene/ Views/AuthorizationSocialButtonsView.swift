import UIKit

final class AuthorizationSocialButtonsView: UIStackView {
    
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
    
    private lazy var googleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "googleLogo"), for: .normal)
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "appleLogo"), for: .normal)
        button.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        return button
    }()
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        alignment = .leading
        distribution = .equalSpacing
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        separatorStackView.addArrangedSubview(separatorLabel)
        separatorStackView.addArrangedSubview(separatorLineView)
        addArrangedSubview(separatorStackView)
        socialButtonStackView.addArrangedSubview(googleButton)
        socialButtonStackView.addArrangedSubview(appleButton)
        addArrangedSubview(socialButtonStackView)
        
        setCustomSpacing(20, after: separatorStackView)
    }
    
    @objc private func didTapGoogleButton() {
        guard let url = Constants.googleLoginURL else {
            Swift.print("Невозможно открыть Google URL")
            return
        }
        UIApplication.shared.open(url)
    }
    
    @objc private func didTapAppleButton() {
        guard let url = Constants.googleLoginURL else {
            Swift.print("Невозможно открыть Apple URL")
            return
        }
        UIApplication.shared.open(url)
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
