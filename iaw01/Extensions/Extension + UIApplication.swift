import UIKit

extension UIApplication {
    var keyWindowIsConnectedScenes: UIWindow? {
        return self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.keyWindow
    }
}
