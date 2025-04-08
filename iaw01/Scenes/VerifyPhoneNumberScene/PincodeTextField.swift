//
//  PincodeTextField.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 21.03.2025.
//

import UIKit

class PincodeTextField: UITextField {
    
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
