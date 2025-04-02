//
//  PhoneNumberInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 28.03.2025.
//

import UIKit

class PhoneNumberInputView: UIView {
    var onVerifyButtonVisibilityChanged: ((Bool) -> Void)?
    private var phoneNumberTextFieldIsActive = true
    private var phoneEditButtonTrailingConstraint: NSLayoutConstraint!
    
    private lazy var phoneNumberTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.keyboardType = .numberPad
        textField.text = "+1 169 916 9564"
        textField.textColor = .dark90
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phoneEditButton: UIButton = {
        let button = UIButton()
        let buttonWidth: CGFloat = 39
        button.setImage(.phoneEditButton, for: .normal)
        button.backgroundColor = .peach60
        button.layer.cornerRadius = buttonWidth / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func editButtonDidTapped() {
        if phoneNumberTextFieldIsActive {
            onVerifyButtonVisibilityChanged?(true)
            phoneEditButton.setImage(.checkmark, for: .normal)
            phoneEditButton.tintColor = .peach100
            phoneNumberTextField.isEnabled = true
            phoneNumberTextField.becomeFirstResponder()
            phoneEditButtonTrailingConstraint = phoneEditButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            phoneEditButtonTrailingConstraint.isActive = true
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            phoneNumberTextFieldIsActive = false
        } else {
            onVerifyButtonVisibilityChanged?(false)
            phoneNumberTextField.resignFirstResponder()
            phoneEditButton.setImage(.phoneEditButton, for: .normal)
            phoneNumberTextField.isEnabled = false
            phoneEditButtonTrailingConstraint.isActive = false
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            phoneNumberTextFieldIsActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhoneNumberInputView {
    private func setupLayout() {
        addSubview(phoneNumberTextFieldView)
        addSubview(phoneEditButton)
        phoneNumberTextFieldView.addSubview(phoneNumberTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            phoneNumberTextFieldView.topAnchor.constraint(equalTo: topAnchor),
            phoneNumberTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneNumberTextFieldView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberTextFieldView.topAnchor),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberTextFieldView.leadingAnchor, constant: 15),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneNumberTextFieldView.trailingAnchor, constant: -15),
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneNumberTextFieldView.bottomAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 39),
            
            phoneEditButton.leadingAnchor.constraint(equalTo: phoneNumberTextFieldView.trailingAnchor, constant: 10),
            phoneEditButton.widthAnchor.constraint(equalToConstant: 39),
            phoneEditButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
}
