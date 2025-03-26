
import UIKit

final class LinkButton: UIButton {

    var onTap: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }

    private let styleLink: LinkButtonStyles

    private lazy var linkLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    init(style: LinkButtonStyles) {
        self.styleLink = style
        super.init(frame: .zero)

        setupLayout()
        setupConstraints()
        setupTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(linkLabel)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        guard let url = styleLink.url else {
            return UIApplication.shared.open(styleLink.errorURL ?? URL(fileURLWithPath: ""))
        }

        UIApplication.shared.open(url)
        onTap?()
    }

    private func setupTitle() {
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
        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: topAnchor),
            linkLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
