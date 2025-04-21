import UIKit

final class RootTabBarView: UIStackView {

    var onTap: ((RootTabBarView) -> Void)?

    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .dark100
        title.frame.size.height = 23
        title.font = UIFont(name: Font.Family.everettRegular.title, size: 12)
        return title
    }()

    init(item: RootTabBarItem) {
        super.init(frame: .zero)

        image.image = item.image
        title.text = item.title

        configure()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func verticalAnimation(isUp: Bool) {
        let transform = isUp ? CGAffineTransform(translationX: 0, y: -4) : .identity

        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut]
        ) {
            self.transform = transform
        }
    }

    @objc private func tapToTab() {
        onTap?(self)
    }

    private func configure() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false

        addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tapToTab))
        )
    }

    private func setupLayout() {
        addArrangedSubview(image)
        addArrangedSubview(title)
    }
}
