import UIKit

class Content: UIView {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var itemTitle: UILabel = {
        let title = UILabel()
        return title
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(.ellipse, for: .normal)
        return button
    }()
    
    //    var price: String?
    
    init(image: UIImageView, title: String) {
        super.init(frame: .zero)
        self.itemImage = image
        self.itemTitle.attributedText = Font.body.compose(title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(itemImage)
        stackView.addArrangedSubview(itemTitle)
        stackView.addArrangedSubview(button)
        
        stackView.setCustomSpacing(2, after: itemImage)
        stackView.setCustomSpacing(10, after: itemTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 14.5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14.5)
        ])
    }
}
