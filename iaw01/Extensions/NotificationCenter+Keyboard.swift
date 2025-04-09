import UIKit

extension NotificationCenter {
    static func registerKeyboardNotifications(_ observer: Any, willShowSelector: Selector, willHideSelector: Selector) {
        NotificationCenter.default.addObserver(
            observer,
            selector: willShowSelector,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            observer, selector: willHideSelector,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    static func unregisterKeyboardNotifications(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(observer, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}
