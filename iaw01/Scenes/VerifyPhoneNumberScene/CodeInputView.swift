//
//  CodeInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 18.03.2025.
//

import UIKit

class PincodeTextField: UITextField {
    weak var previousTextField: UITextField?
    
    override func deleteBackward() {
        super.deleteBackward()
        if self.text?.isEmpty ?? true {
            self.previousTextField?.becomeFirstResponder()
            previousTextField?.text = ""
        }
    }
}

class CodeInputView: UIView {

    private lazy var digitsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<6 {
            let textField = createTextField()
            textField.tag = i
            codeDigits.append(textField)
            stack.addArrangedSubview(textField)
        }
        return stack
    }()
    
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
        addSubview(digitsStackView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            digitsStackView.topAnchor.constraint(equalTo: topAnchor),
            digitsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            digitsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            digitsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            digitsStackView.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func createTextField() -> PincodeTextField {
        let textField = PincodeTextField()
        textField.font = Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .light80
        textField.textColor = .dark100
        textField.delegate = self
//        textField.isUserInteractionEnabled = false
        
        if let previousTextField = codeDigits.last {
            textField.previousTextField = previousTextField
        }
        return textField
    }
}

// MARK: - UITextFieldDelegate
extension CodeInputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            textField.text = ""
            return false
        }
            
        if newText.count == 1 {
            textField.text = newText
            if let nextTextField = self.codeDigits[safe: textField.tag + 1] {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return false
        }
        return false
    }
}

// MARK: - Safe Access to Array
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
