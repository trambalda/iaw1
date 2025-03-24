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
        
        for i in 1...6 {
            let textField = createTextField
            textField.tag = i
            codeDigits.append(textField)
            stack.addArrangedSubview(textField)
            stack.isUserInteractionEnabled = false
            
            if textField.tag != 1 {
                textField.isUserInteractionEnabled = false
            }
            
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTapOnView))
            self.addGestureRecognizer(tapGesture)
        }
        
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
        codeDigits.allSatisfy { $0.text != nil && $0.text!.isEmpty == false
            }
    }

    private var codeDigits: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        codeDigits.first?.becomeFirstResponder()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTapOnView(_ gesture: UITapGestureRecognizer) {
        guard let _ = gesture.view else { return }
        
        if isPincodeFilled {
            for field in codeDigits {
                field.text = ""
            }
            codeDigits.first?.becomeFirstResponder()
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
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


