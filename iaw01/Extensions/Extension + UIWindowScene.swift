import UIKit

extension UIWindowScene {
    var keyWindow: UIWindow? {
        return self.windows.first { $0.isKeyWindow }
    }
}
