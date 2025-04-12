import UIKit

final class RootTabBarView: UIView {

    var onTap: ((RootTabBarView) -> Void)?

    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .dark100
        title.font = UIFont(name: Font.Family.everettRegular.title, size: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(item: RootTabBarItem) {
        super.init(frame: .zero)

        image.image = item.image
        title.text = item.title

        configure()
        setupLayout()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
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
            self.stack.transform = transform
        }
    }

    @objc private func tapToTab() {
        onTap?(self)
    }

    private func configure() {
        stack.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(tapToTab))
        )
    }

    private func setupLayout() {
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(title)
        addSubview(stack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),

            title.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
