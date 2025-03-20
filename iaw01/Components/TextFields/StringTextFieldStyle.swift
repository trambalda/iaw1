import UIKit

struct StringTextFieldStyle {
    var title: String?
    let placeholder: String
    var text: String?
    let keyboardType: UIKeyboardType?
}

extension StringTextFieldStyle {
    static let nameStyle = StringTextFieldStyle(
        title: "Full Name",
        placeholder: "Enter your Name",
        keyboardType: .default
    )
    
    static let emailStyle = StringTextFieldStyle(
        title: "Email Address",
        placeholder: "Enter your Email",
        keyboardType: .emailAddress
    )
}
