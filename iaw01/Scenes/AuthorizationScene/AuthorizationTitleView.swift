import UIKit

final class AuthorizationTitleView: UIStackView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Welcome", color: .dark100)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Sign up or Login to your Account", color: .dark80)
        return label
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
        setupStackView()
        setupLayout()
    }
    
    private func setupStackView() {
        axis = .vertical
        spacing = -3
    }
    
    private func setupLayout() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
    }
}


