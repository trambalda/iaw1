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
    
    var onCodeEntered: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
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
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }
    
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
            notifyCodeEntered()
        } else if text.count == 1 {
            // Переходим к следующему полю
            if let nextTextField = codeDigits[safe: textField.tag + 1] {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                notifyCodeEntered()
            }
        }
    }
    
    private func notifyCodeEntered() {
        let code = codeDigits.compactMap { $0.text }.joined()
        if code.count == 6 {
            onCodeEntered?(code)
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
        return newText.count <= 1
    }
}

// MARK: - Safe Access to Array
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
