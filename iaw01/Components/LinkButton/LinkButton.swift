
import UIKit

final class LinkButton: UIButton {

    var onTapButton: (() -> Void)?
    private let styleLink: LinkButtonStyles

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }

    private lazy var linkLabel = UILabel()

    init(style: LinkButtonStyles) {
        self.styleLink = style
        super.init(frame: .zero)

        setupUI()
        setupConstraints()
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(linkLabel)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        if let url = styleLink.url {
            UIApplication.shared.open(url)
        }
        onTapButton?()
    }

    private func updateAppearance() {
        let attributedText = NSAttributedString(
            string: styleLink.title,
            attributes: [
                .foregroundColor: styleLink.textColor,
                .font: Font.body.font,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        linkLabel.attributedText = attributedText
    }

    private func setupConstraints() {
        linkLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: topAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
