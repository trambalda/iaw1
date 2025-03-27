
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
        var imageView = UIImageView()
        imageView.image = !isActive ? tabBarItem.image : tabBarItem.selectedImage
        imageView.tintColor = .dark100
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()

        return label
    }()


    init(tabBarItem: TabBarItem, imageConstraints: NSLayoutConstraint? = nil,
         isActive: Bool, isSelected: @escaping (TabBarView) -> Void) {

        self.tabBarItem = tabBarItem
        self.imageConstraints = imageConstraints
        self.isActive = isActive
        self.isSelected = isSelected

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    




}
