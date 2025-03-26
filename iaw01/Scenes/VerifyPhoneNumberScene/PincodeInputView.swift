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
        
        var previousTextField: PincodeTextField?
        
        for i in 1...6 {
            let textField = createTextField
            textField.tag = i
            if i == 1 {
                textField.isUserInteractionEnabled = true
            } else {
                textField.isUserInteractionEnabled = false
            }
            textField.previousTextField = previousTextField
            
            stack.addArrangedSubview(textField)
            previousTextField = textField
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
        return textField
    }
    
    private var isPincodeFilled: Bool {
        stackView.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .allSatisfy { $0.text.notNilNotEmpty }
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            (self?.stackView.arrangedSubviews.first as? UITextField)?.becomeFirstResponder()
        }
    }
    
    private func addTapGestureForStartPincodeInput() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOnView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOnView(_ gesture: UITapGestureRecognizer) {
        resetPincode()
    }
    
    private func resetPincode() {
        guard isPincodeFilled else {
            return
        }
        
        stackView.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .forEach { $0.text = "" }
        (stackView.arrangedSubviews.first as? UITextField)?.becomeFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
        showKeyBoardWithDelay()
        addTapGestureForStartPincodeInput()
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
            if let nextTextField = stackView.arrangedSubviews.first(where: {($0 as? UITextField)?.tag == textField.tag + 1 }) as? UITextField {
                nextTextField.isUserInteractionEnabled = true
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return false
    }
}


