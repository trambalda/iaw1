//
//  CodeInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 18.03.2025.
//

import UIKit

class PincodeInputView: UIView {

    private lazy var pincodeTextFieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 1...6 {
            let textField = createTextField
            textField.tag = i
            codeDigits.append(textField)
            stack.addArrangedSubview(textField)
        }
        return stack
    }()
    
    private var createTextField: PincodeTextField {
        let textField = PincodeTextField()
        textField.font = Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .light80
        textField.textColor = .dark100
        textField.delegate = self
        
        if let previousTextField = codeDigits.last {
            textField.previousTextField = previousTextField
        }
        return textField
    }
    
    private var codeDigits: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        codeDigits.first?.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(pincodeTextFieldsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pincodeTextFieldsStackView.topAnchor.constraint(equalTo: topAnchor),
            pincodeTextFieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pincodeTextFieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pincodeTextFieldsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pincodeTextFieldsStackView.heightAnchor.constraint(equalToConstant: 58)
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
        } else if newText.count == 1 {
            textField.text = newText
            if textField.tag < codeDigits.count {
                let nextTextField = codeDigits[textField.tag]
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return false
    }
}

