import UIKit

class ExpandableViewsButton: CustomCircleButton {
    
    private var isViewExpandeded = false
    
    private func configureExpandButton() {
        let addButtonImage = UIImage(resource: .addButton)
        let removeButtonImage = UIImage(resource: .removeButton)
        
        configureButtonWith(
            image: UIImage(resource: .addButton),
            shouldHighlight: true
        ) { [weak self] in
            guard let self = self else { return }
            self.setImage(self.isViewExpandeded ? addButtonImage : removeButtonImage, for: .normal)
            self.isViewExpandeded.toggle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureExpandButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
