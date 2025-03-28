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
            let textField = pincodeTextField
            textField.tag = i
            textField.previousTextField = previousTextField
            
            stack.addArrangedSubview(textField)
            previousTextField = textField
        }
        
        stack.arrangedSubviews.first?.isUserInteractionEnabled = true
        
        return stack
    }()
    
    private var pincodeTextField: PincodeTextField {
        let textField = PincodeTextField()
        textField.font =  Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .light80
        textField.textColor = .dark100
        textField.delegate = self
        textField.tintColor = .clear
        textField.isUserInteractionEnabled = false
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
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func firstTextFieldBecomeFirstResponder() {
        (stackView.arrangedSubviews.first as? PincodeTextField)?.becomeFirstResponder()
    }
    
    private func addTapGestureForStartPincodeInput() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapOnView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOnView() {
        resetPincode()
    }
    
    private func resetPincode() {
        guard isPincodeFilled else { return }
        
        stackView.arrangedSubviews
            .compactMap { $0 as? UITextField }
            .forEach { $0.text = "" }
        firstTextFieldBecomeFirstResponder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
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
            if let nextTextField = findTextField(with: textField.tag + 1) {
                nextTextField.isUserInteractionEnabled = true
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        return false
    }
    
    private func findTextField(with tag: Int) -> UITextField? {
        for view in stackView.arrangedSubviews {
            if let textField = view as? UITextField, textField.tag == tag {
                return textField
            }
        }
        return nil
    }
}


