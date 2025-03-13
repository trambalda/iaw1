import UIKit

extension UITextField {
    
    func applyCommonStyle(placeholder: String? = nil, keyboardType: UIKeyboardType = .default) {
        self.autocapitalizationType = .none
        self.textColor = .dark100
        self.backgroundColor = .light80
        self.textAlignment = .left
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.foregroundColor: UIColor.dark80]
        )
    }
}
