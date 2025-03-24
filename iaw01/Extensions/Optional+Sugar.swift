//
//  Optional+Sugar.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 24.03.2025.
//

import Foundation

extension Optional where Wrapped == String {
    var noTNilNotEmpty: Bool {
        self?.isEmpty == false
    }
}
