
import UIKit

struct LinkButtonStyles {
    let textColor: UIColor
    let title: String
    let url: URL?
}

extension LinkButtonStyles {
    static let forgotPassword = LinkButtonStyles(
        textColor: .dark80,
        title: "Forgot Password?",
        url: nil
    )

    static let getNewCode = LinkButtonStyles(
        textColor: .pink100,
        title: "Get a New one",
        url: nil
    )
}
