//
//  CodeInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 18.03.2025.
//

import UIKit

class PincodeInputView: UIView {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        
        for i in 1...6 {
            let textField = createTextField
            textField.tag = i
            textField.isUserInteractionEnabled = false
            
            codeDigits.append(textField)
            stack.addArrangedSubview(textField)
        }
        
        codeDigits.first?.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOnView))
        addGestureRecognizer(tapGesture)
        
        return stack
    }()
    
    private var createTextField: PincodeTextField {
        let textField = PincodeTextField()
        textField.font =  Font.subtitle1.font
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
    
    @objc func handleTapOnView(_ gesture: UITapGestureRecognizer) {
        resetPincode()
    }
    
    private func resetPincode() {
        if isPincodeFilled {
            for field in codeDigits {
                field.text = ""
            }
            codeDigits.first?.becomeFirstResponder()
        }
    }
    
    private func setupLayoutAndConstraints() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func showKeyBoardWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3) {
                self.codeDigits.first?.becomeFirstResponder()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
        showKeyBoardWithDelay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            }
        }
        return false
    }
}


