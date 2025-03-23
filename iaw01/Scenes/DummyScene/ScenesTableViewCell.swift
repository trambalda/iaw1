import UIKit

final class ScenesTableViewCell: UITableViewCell {
    
    static let cellId = "ScenesTableViewCell"
    
    var model: SceneModel? {
        didSet {
            titleLabel.text = model?.sceneType.title
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowRightImageView: UIImageView = {
        let imageView = UIImageView(image: .arrowRight)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        selectionStyle = .none

        setupLayoutAndConstraints()
    }
    
    private func setupLayoutAndConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowRightImageView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowRightImageView.leadingAnchor, constant: -8),
            arrowRightImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowRightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowRightImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
