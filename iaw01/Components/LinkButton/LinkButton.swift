import UIKit

final class LinkButton: UIButton {
    
    var onTap: (() -> ())?

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }

    private let style: LinkButtonStyle

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: style.title,
            attributes: [
                .foregroundColor: style.textColor,
                .font: Font.body.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        return label
    }()

    init(style: LinkButtonStyle) {
        self.style = style
        super.init(frame: .zero)

        configure()
        setupLayout()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(label)
    }

    private func configure() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        if let urlString = style.url {
            let url = URL(string: urlString) ?? Constants.url404
            UIApplication.shared.open(url)
        } else {
            onTap?()
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
