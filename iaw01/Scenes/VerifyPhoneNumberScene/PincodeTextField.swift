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
        if self.text?.isEmpty ?? true {
            previousTextField?.isUserInteractionEnabled = true
            self.previousTextField?.becomeFirstResponder()
            previousTextField?.text = ""
        }
    }
}
