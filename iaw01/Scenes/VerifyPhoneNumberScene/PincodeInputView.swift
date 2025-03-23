//
//  CodeInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 18.03.2025.
//

import UIKit

class PincodeInputView: UIStackView {
    private var createTextField: PincodeTextField {
        let textField = PincodeTextField()
        textField.font = Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .light80
        textField.textColor = .dark100
        textField.delegate = self
        textField.tintColor = .clear
        
        if let previousTextField = codeDigits.last {
            textField.previousTextField = previousTextField
        }
        return textField
    }
    
    private var isPincodeFilled: Bool {
        codeDigits.allSatisfy {
            $0.text != nil && $0.text!.isEmpty == false
        }
    }
    
    private var codeDigits: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        codeDigits.first?.becomeFirstResponder()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.spacing = 15
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 1...6 {
            let textField = createTextField
            textField.tag = i
            codeDigits.append(textField)
            self.addArrangedSubview(textField)
            
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTextFieldTap)
            )
            textField.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func handleTextFieldTap(_ gesture: UITapGestureRecognizer) {
        guard let textField = gesture.view as? UITextField else { return }
        
        if isPincodeFilled {
            for field in codeDigits {
                field.isUserInteractionEnabled = true
            }
            
            for field in codeDigits {
                field.text = ""
            }
            codeDigits.first?.becomeFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
    }
}

extension PincodeInputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
            
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            textField.text = ""
        } else {
            textField.text = newText
            if textField.tag < codeDigits.count {
                let nextTextField = codeDigits[textField.tag]
                nextTextField.isUserInteractionEnabled = true
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                for item in codeDigits {
                    item.isUserInteractionEnabled = true
                }
            }
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard isPincodeFilled else { return }
        var tmpArr = codeDigits
        tmpArr.remove(at: textField.tag - 1)
        for item in tmpArr {
            item.isUserInteractionEnabled = false
        }
    }
}

