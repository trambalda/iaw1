//
//  NotificationCenter.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 31.03.2025.
//
import UIKit

extension NotificationCenter {
    static func registerKeyboardNotifications(
        _ observer: Any,
        selector: Selector,
        name: NSNotification.Name?) {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: name,
            object: nil)
    }
    
    static func unregisterKeyboardNotifications(
        _ observer: Any,
        name: NSNotification.Name?) {
        NotificationCenter.default.removeObserver(
            observer,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}
