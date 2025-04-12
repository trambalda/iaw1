import UIKit

class SelectCheckBox: CustomCircleButton {
    
    private var isCheckBoxSelected = false
    
    private func configureExpandButton() {
        configureButtonWith(image: UIImage(resource: .ellipse), shouldHighlight: false) { [weak self] in
            guard let self = self else { return }
            self.setImage(UIImage(resource: .ellipseFill), for: .normal)
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
