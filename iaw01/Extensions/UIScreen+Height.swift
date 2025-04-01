//
//  UIScreen.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 01.04.2025.
//

import UIKit

extension UIScreen {
    static var isSmallScreen: Bool {
        return main.bounds.height <= 667
    }
}
