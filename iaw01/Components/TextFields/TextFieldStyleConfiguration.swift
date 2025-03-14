import Foundation
import UIKit

struct BaseTextFieldStyle {
    let autocapitalizationType: UITextAutocapitalizationType = .none
    var textColor: UIColor = UIColor(resource: .dark100)
    var backgroundColor: UIColor = UIColor(resource: .light80)
    let textSize: CGFloat = 17
    let fontFamily: UIFont = Font.body ?? UIFont.systemFont(ofSize: 17)
    let attributedPlaceholder: NSAttributedString?

    init(placeholder: String? = nil) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [.foregroundColor: UIColor(resource: .dark80)]
        )
    }
}

struct StringTextFieldStyle {
    var title: String?
    let placeholder: String?
    var text: String?
    let keyboardType: UIKeyboardType?
    let baseStyle: BaseTextFieldStyle

    init(title: String? = nil, placeholder: String? = nil, text: String? = nil, keyboardType: UIKeyboardType? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.text = text
        self.keyboardType = keyboardType
        self.baseStyle = BaseTextFieldStyle(placeholder: placeholder)
    }
}

extension StringTextFieldStyle {
    static let nameStyle = StringTextFieldStyle(
        title: "Full Name",
        placeholder: "Enter your Name",
        keyboardType: .default)
    
    static let emailStyle = StringTextFieldStyle(
        title: "Email Address",
        placeholder: "Enter your Email",
        keyboardType: .emailAddress)
}

