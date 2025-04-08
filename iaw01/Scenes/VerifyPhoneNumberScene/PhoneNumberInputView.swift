//
//  PhoneNumberInputView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 28.03.2025.
//

import UIKit

class PhoneNumberInputView: UIView {
    
    private var phoneNumberTextFieldIsActive = true
    
    private var phoneEditButtonTrailingConstraint: NSLayoutConstraint!
    
    private lazy var phoneNumberTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // TODO: переделать после того как появится текстфилд с вводом номера телефона
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
            phoneEditButton.setImage(.checkmark, for: .normal)
            phoneEditButton.tintColor = .peach100
            phoneNumberTextField.isEnabled = true
            phoneNumberTextField.becomeFirstResponder()
            phoneEditButtonTrailingConstraint = phoneEditButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        } else {
            phoneNumberTextField.resignFirstResponder()
            phoneEditButton.setImage(.phoneEditButton, for: .normal)
            phoneNumberTextField.isEnabled = false
        }
        phoneNumberTextFieldIsActive.toggle()
        phoneEditButtonTrailingConstraint.isActive.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
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
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberTextFieldView.layoutMarginsGuide.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: phoneNumberTextFieldView.layoutMarginsGuide.trailingAnchor),
            phoneNumberTextField.bottomAnchor.constraint(equalTo: phoneNumberTextFieldView.bottomAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 39),
            
            phoneEditButton.leadingAnchor.constraint(equalTo: phoneNumberTextFieldView.trailingAnchor, constant: 10),
            phoneEditButton.widthAnchor.constraint(equalToConstant: 39),
            phoneEditButton.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
}
