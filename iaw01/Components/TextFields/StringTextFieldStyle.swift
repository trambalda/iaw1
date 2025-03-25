import UIKit

struct StringTextFieldStyle {
    enum Behavior {
        case string
        case email
        case password
        case phoneNumber
        
        var isSecure: Bool {
            self == .password
        }
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .string:       .default
            case .email:        .emailAddress
            case .password:     .default
            case .phoneNumber:  .default
            }
        }
    }
    
    var title: String?
    let placeholder: String
    var text: String?
    let behavior: Behavior
}

extension StringTextFieldStyle {
    static let nameStyle = StringTextFieldStyle(
        title: "Full Name",
        placeholder: "Enter your Name",
        behavior: .string
    )
    
    static let emailStyle = StringTextFieldStyle(
        title: "Email Address",
        placeholder: "Enter your Email",
        behavior: .email
    )
    
    static let passwordStyle = StringTextFieldStyle(
        title: "Password",
        placeholder: "Enter your Password",
        behavior: .password
    )
    
    static let createPasswordStyle = StringTextFieldStyle(
        title: "Create Password",
        placeholder: "Enter your Password",
        behavior: .password
    )
    
    static let phoneNumberStyle = StringTextFieldStyle(
        title: "Phone Number",
        placeholder: "000 000 0000",
        behavior: .phoneNumber
    )
}
