import UIKit

extension UIApplication {
    static var rootViewController: UIViewController? {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController
        else {
            return nil
        }
        return rootViewController
    }
} 
