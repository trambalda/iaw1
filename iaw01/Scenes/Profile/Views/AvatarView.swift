import UIKit

class AvatarView: UIView {

    private lazy var image: UIImageView = {
        let image = UIImageView(image: .avatar)
        image.layer.cornerRadius = image.frame.width / 2
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(image)
    }
}
