//
//  Optional+Sugar.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 24.03.2025.
//

extension Optional where Wrapped == String {
    var notNilNotEmpty: Bool {
        self?.isEmpty == false
    }
}
