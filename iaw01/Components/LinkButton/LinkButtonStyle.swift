
import UIKit

struct LinkButtonStyle {
    let textColor: UIColor
    let title: String
    let url: URL?
    let errorURL: URL? = URL(string: "https://www.figma.com/404")
}

extension LinkButtonStyle {
    static let forgotPassword = LinkButtonStyle(
        textColor: .dark80,
        title: "Forgot Password?",
        url: URL(string: "https://")
    )

    static let getNewCode = LinkButtonStyle(
        textColor: .pink100,
        title: "Get a New one",
        url: nil
    )
}
