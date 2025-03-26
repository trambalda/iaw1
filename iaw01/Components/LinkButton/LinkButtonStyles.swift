
import UIKit

struct LinkButtonStyles {
    let textColor: UIColor
    let title: String
    let url: URL?
    let errorURL: URL? = URL(string: "https://www.figma.com/404")
}

extension LinkButtonStyles {
    static let forgotPassword = LinkButtonStyles(
        textColor: .dark80,
        title: "Forgot Password?",
        url: URL(string: "https://")
    )

    static let getNewCode = LinkButtonStyles(
        textColor: .pink100,
        title: "Get a New one",
        url: nil
    )
}
