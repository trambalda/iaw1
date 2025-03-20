import UIKit

struct TextFieldBaseStyle {
    let autocapitalizationType: UITextAutocapitalizationType = .none
    let titleColor: UIColor = .dark100
    let textColor: UIColor = .dark100
    let backgroundColor: UIColor = .light80
    let fontFamily = Font.body 
    let font: UIFont = Font.body.font
    let placeholderColor: UIColor = .dark60
}

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

