import UIKit

struct PhoneTextFieldStyle {
    var title: String?
    let placeholder: String
    var text: String?
}

extension PhoneTextFieldStyle {
    static let phoneNumberStyle = PhoneTextFieldStyle(
        title: "Phone Number",
        placeholder: "000 000 0000"
    )
}

