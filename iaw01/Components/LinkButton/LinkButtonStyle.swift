
import UIKit

struct LinkButtonStyle {
    let textColor: UIColor
    let title: String
    let url: String?
}

extension LinkButtonStyle {
    static let forgotPassword = LinkButtonStyle(
        textColor: .dark80,
        title: "Forgot Password?",
        url: "https://"
    )

    static let getNewCode = LinkButtonStyle(
        textColor: .pink100,
        title: "Get a New one",
        url: nil
    )
}
