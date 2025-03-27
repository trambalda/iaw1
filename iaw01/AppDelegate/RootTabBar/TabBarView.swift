
import UIKit

final class TabBarView: UIView {

    var tabBarItem: TabBarItem
    var imageConstraints: NSLayoutConstraint?
    var isActive: Bool {
        willSet {

        }
    }
    var isSelected: (TabBarView) -> Void

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = !isActive ? tabBarItem.image : tabBarItem.selectedImage
        imageView.tintColor = .dark100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .dark100
        label.font = isActive
        ? UIFont(name: Font.Family.everettMedium.title, size: 12)!
        : UIFont(name: Font.Family.everettRegular.title, size: 12)!

        label.attributedText = NSMutableAttributedString(
            string: tabBarItem.title,
            attributes: [.kern: Font.caption.lettering]
        )

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var dot: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = isActive ? .dark100 : .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.widthAnchor.constraint(equalToConstant: 5).isActive = true
        return view
    }()


    init(tabBarItem: TabBarItem, imageConstraints: NSLayoutConstraint? = nil,
         isActive: Bool, isSelected: @escaping (TabBarView) -> Void) {

        self.tabBarItem = tabBarItem
        self.imageConstraints = imageConstraints
        self.isActive = isActive
        self.isSelected = isSelected

        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        let viewArray = [image, title]

        viewArray.forEach { view in
            stackView.addArrangedSubview(view)
        }

        addSubview(stackView)
        addSubview(dot)

    }

    @objc private func tapToTab() {
        self.isSelected(self)
    }

    private func setupConstraints() {
        imageConstraints = dot.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -2)
        imageConstraints?.isActive = !isActive

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
    }




}

