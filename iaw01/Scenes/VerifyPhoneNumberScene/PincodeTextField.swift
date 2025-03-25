//
//  PincodeTextField.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 21.03.2025.
//

import UIKit

class PincodeTextField: UITextField {
    init() {
        super.init(frame: .zero)
        print("PincodeTextField Inited")
    }
    
    deinit {
        print("PincodeTextField DEallocated")
        debugPrint("? deinit \(self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var previousTextField: UITextField?
    
    override func deleteBackward() {
        super.deleteBackward()
        guard text.notNilNotEmpty else {
            previousTextField?.text = ""
            previousTextField?.becomeFirstResponder()
            return
        }
    }
}
