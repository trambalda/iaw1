//
//  CodeInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 18.03.2025.
//

import UIKit

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
        updateTextFieldInteractions(currentTextField: codeDigits.first)
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
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.font = Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .light80
        textField.textColor = .dark100
        textField.tintColor = .clear
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }
    
    private func updateTextFieldInteractions(currentTextField: UITextField?) {
        for textField in codeDigits {
            textField.isUserInteractionEnabled = true
//            textField.isUserInteractionEnabled = (textField == currentTextField)
        }
    }
    // TODO: Доработать перемещение фокуса на предыдущую ячейку в моменте ввода кода
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 1 {
            // Разбиваем вставленный текст на символы
            let characters = Array(text)
            for (index, char) in characters.enumerated() {
                if let field = codeDigits[safe: index] {
                    field.text = String(char)
                }
            }
            textField.resignFirstResponder()
        } else if text.count == 1 {
            // Переходим к следующему полю
            if let nextTextField = codeDigits[safe: textField.tag + 1] {
                updateTextFieldInteractions(currentTextField: nextTextField)
                nextTextField.becomeFirstResponder()
            }
        } else if text.isEmpty {
            if textField.tag > 0 {
                if let previousTextField = codeDigits[safe: textField.tag - 1] {
                    updateTextFieldInteractions(currentTextField: previousTextField)
                    previousTextField.becomeFirstResponder()
                }
            }
        }
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
                return true
            }
            
        return newText.count <= 1
    }
}

// MARK: - Safe Access to Array
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
