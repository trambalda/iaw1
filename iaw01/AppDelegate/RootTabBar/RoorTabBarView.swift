
import UIKit

final class TabBarVIews: UIView {

    var item: RootTabBarItem
    var isSelected: (TabBarVIews) -> Void

    var isActive: Bool {
        willSet {
            self.indicator.alpha = newValue ? 1 : 0
            self.image.image = newValue ? self.item.selectedImage : self.item.image

            self.title.font = newValue
            ? UIFont(name: Font.Family.everettMedium.title, size: 12)
            : UIFont(name: Font.Family.everettRegular.title, size: 12)

            let transform = newValue ? CGAffineTransform(translationX: 0, y: -2) : .identity

            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.5,
                options: [.curveEaseOut, .transitionCrossDissolve]
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
        view.addSubviews(subviews: image, title, indicator)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = !isActive ? item.image : item.selectedImage
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .dark100
        title.text = item.title

        title.font = isActive
        ? UIFont(name: Font.Family.everettMedium.title, size: 12)
        : UIFont(name: Font.Family.everettRegular.title, size: 12)

        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .dark100
        view.alpha = !isActive ? 0 : 1
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(tabItem: RootTabBarItem, imageRightConstraints: NSLayoutConstraint? = nil, isActive: Bool,
         isSelected: @escaping (TabBarVIews) -> Void) {

        self.item = tabItem
        self.animationConstraint = imageRightConstraints
        self.isActive = isActive
        self.isSelected = isSelected
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
        self.isSelected(self)
    }

    private func setupLayout() {
        addSubview(container)
    }

    private func setupIsActive() {
        if isActive {
            image.transform = CGAffineTransform(translationX: 0, y: -2)
            title.transform = CGAffineTransform(translationX: 0, y: -2)
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
            title.bottomAnchor.constraint(equalTo: indicator.topAnchor, constant: -6),

            indicator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            indicator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 5),
            indicator.widthAnchor.constraint(equalToConstant: 5)
        ])
    }
}

    // Extension for UIView to add multiple subviews at once
extension UIView {

    func addSubviews(subviews: UIView...) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
}
