import UIKit

extension UIApplication {
    static var rootViewController: UIViewController? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
    }

    static var keyWindowIsConnectedScenes: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first { $0.isKeyWindow }
    }
}
