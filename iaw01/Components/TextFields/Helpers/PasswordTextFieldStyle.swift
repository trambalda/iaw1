import UIKit

struct PasswordTextFieldStyle {
    var title: String?
    let placeholder: String
    var text: String?
}

extension PasswordTextFieldStyle {
    static let passwordStyle = PasswordTextFieldStyle(
        title: "Password",
        placeholder: "Enter your Password"
    )
    
    static let createPasswordStyle = PasswordTextFieldStyle(
        title: "Create Password",
        placeholder: "Enter your Password"
    )
}
