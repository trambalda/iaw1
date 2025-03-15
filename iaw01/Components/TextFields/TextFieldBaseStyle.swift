import UIKit

struct TextFieldBaseStyle {
    let autocapitalizationType: UITextAutocapitalizationType = .none
    let textColor: UIColor = .dark100
    let backgroundColor: UIColor = .light80
    let fontFamily = Font.body
}

struct StringTextFieldStyle {
    var title: String?
    let placeholder: String?
    var text: String?
    let fontFamily = Font.body
    let keyboardType: UIKeyboardType?
    let baseStyle = TextFieldBaseStyle()
    var attributedPlaceholder: NSAttributedString? {
        placeholder.map {
            NSAttributedString(string: $0, attributes: [.foregroundColor: UIColor.dark80])
        }
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

