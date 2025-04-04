
import UIKit

final class RootTabBarView: UIView {

    var item: RootTabBarItem
    var onTap: ((RootTabBarView) -> Void)?

    var isActive: Bool {
        willSet {
            let transform = newValue ? CGAffineTransform(translationX: 0, y: -3) : .identity

            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: [.curveEaseOut]
            ) {
                [weak self] in
                guard let self else { return }

                self.image.transform = transform
                self.title.transform = transform
                self.layoutIfNeeded()
            }
        }
    }

    private var animationConstraint: NSLayoutConstraint?

    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = item.image
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .dark100
        title.text = item.title
        title.font = UIFont(name: Font.Family.everettRegular.title, size: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    init(tabItem: RootTabBarItem, isActive: Bool) {
        self.item = tabItem
        self.isActive = isActive
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        setupLayout()
        setupConstraints()
        setupIsActive()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapToTab() {
        onTap?(self)
    }

    private func setupLayout() {
        container.addSubview(image)
        container.addSubview(title)
        addSubview(container)
    }

    private func setupIsActive() {
        if isActive {
            image.transform = CGAffineTransform(translationX: 0, y: -3)
            title.transform = CGAffineTransform(translationX: 0, y: -3)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),

            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25),

            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6),
        ])
    }
}
