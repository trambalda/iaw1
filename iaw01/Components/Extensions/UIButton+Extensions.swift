import UIKit

extension UIButton {
    func setTitleFont(_ font: UIFont, for state: UIControl.State) {
        switch state {
        case .normal:
            self.titleLabel?.font = font
        case .selected:
            self.titleLabel?.font = font
        default:
            break
        }
    }
}
