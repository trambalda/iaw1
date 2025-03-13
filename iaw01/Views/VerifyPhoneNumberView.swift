//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {

    // UI-компоненты
    private let verifyHeaderLabel = UILabel()
    private let verifyDescLabel = UILabel()
    private let phoneNumberTextField = UITextField()
    private let containerViewForTextField = UIView()
    private let phoneEditButton = UIButton()
    private let digitsStackView = UIStackView()
    private var codeDigits: [UITextField] = []
    private let getNewCodeStackView = UIStackView()
    private let getNewCodeLabel = UILabel()
    private let getNewCodeButton = UIButton()
    private let verifyButton = UIButton()
    
    private let padding: CGFloat = 21
    
    // Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка интерфейса
    private func setupUI() {
        configureVerifyHeaderLabel()
        configureVerifyDescLabel()
        configurePhoneNumberTextField()
        configurePhoneEditButton()
        configureCodeDigitsTextFields()
        configureGetNewCode()
        configureVerifyButton()
    }
    
    private func configureVerifyHeaderLabel() {
        verifyHeaderLabel.text = "Verify Phone Number"
        verifyHeaderLabel.font = Font.heading4
        verifyHeaderLabel.numberOfLines = 1
        verifyHeaderLabel.textAlignment = .center
        verifyHeaderLabel.adjustsFontSizeToFitWidth = true
        verifyHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(verifyHeaderLabel)
        
        NSLayoutConstraint.activate([
            verifyHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            verifyHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    private func configureVerifyDescLabel() {
        verifyDescLabel.text = "We have sent you a 6 digit code. Please enter here to Verify your Number."
        verifyDescLabel.textColor = UIColor(resource: .dark80)
        verifyDescLabel.font = Font.body
        verifyDescLabel.numberOfLines = 0
        verifyDescLabel.textAlignment = .justified
        verifyDescLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(verifyDescLabel)
        
        NSLayoutConstraint.activate([
            verifyDescLabel.topAnchor.constraint(equalTo: verifyHeaderLabel.bottomAnchor, constant: 10),
            verifyDescLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyDescLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    private func configurePhoneNumberTextField() {
        containerViewForTextField.backgroundColor = UIColor(resource: .light80)
        containerViewForTextField.layer.cornerRadius = 20
        containerViewForTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerViewForTextField)
          
        phoneNumberTextField.text = "+1 169 916 9564"
        phoneNumberTextField.textColor = UIColor(resource: .dark90)
        phoneNumberTextField.backgroundColor = UIColor.clear
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        containerViewForTextField.addSubview(phoneNumberTextField)
        
        NSLayoutConstraint.activate([
            containerViewForTextField.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor, constant: padding),
            containerViewForTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            containerViewForTextField.heightAnchor.constraint(equalToConstant: 39),
            
            phoneNumberTextField.centerYAnchor.constraint(equalTo: containerViewForTextField.centerYAnchor),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: containerViewForTextField.leadingAnchor, constant: 10),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor, constant: -10)
        ])
    }

    private func configurePhoneEditButton() {
        let buttonWidth: CGFloat = 39
        
        phoneEditButton.setImage(UIImage(named: "Frame 124"), for: .normal)
        phoneEditButton.backgroundColor = UIColor(resource: .peach60)
        phoneEditButton.layer.cornerRadius = buttonWidth / 2
        phoneEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(phoneEditButton)
        
        NSLayoutConstraint.activate([
            phoneEditButton.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor, constant: padding),
            phoneEditButton.leadingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor, constant: padding),
            phoneEditButton.heightAnchor.constraint(equalToConstant: buttonWidth),
            phoneEditButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            phoneEditButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

    private func configureCodeDigitsTextFields() {
        digitsStackView.axis = .horizontal
        digitsStackView.spacing = 15
        digitsStackView.distribution = .fillEqually
        digitsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<6 {
            let textField = createTextField()
            codeDigits.append(textField)
            digitsStackView.addArrangedSubview(textField)
        }
        addSubview(digitsStackView)
        
        NSLayoutConstraint.activate([
            digitsStackView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 45),
            digitsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digitsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            digitsStackView.heightAnchor.constraint(equalToConstant: 58)
        ])
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.font = Font.subtitle1
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.textColor = UIColor(resource: .dark100)
        textField.backgroundColor = UIColor(resource: .light80)
        return textField
    }

    private func configureGetNewCode() {
        getNewCodeStackView.axis = .horizontal
        getNewCodeStackView.distribution = .fill
        getNewCodeStackView.spacing = 1
        getNewCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        getNewCodeLabel.text = "Didn't Receive Code?"
        getNewCodeLabel.font = Font.body
        getNewCodeLabel.textColor = UIColor(resource: .dark80)
        
        getNewCodeStackView.addArrangedSubview(getNewCodeLabel)
        
        getNewCodeButton.setTitle("", for: .normal)
        getNewCodeButton.titleLabel?.textColor = UIColor(resource: .pink100)
        
        let attributedTitle = NSMutableAttributedString(string: "Get a New one")
        attributedTitle.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedTitle.length))
        
        getNewCodeButton.setAttributedTitle(attributedTitle, for: .normal)
        
        getNewCodeStackView.addArrangedSubview(getNewCodeButton)
        
        addSubview(getNewCodeStackView)
        
        NSLayoutConstraint.activate([
            getNewCodeStackView.topAnchor.constraint(equalTo: digitsStackView.bottomAnchor, constant: 60),
            getNewCodeStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func configureVerifyButton() {
        verifyButton.setImage(UIImage(named: "Frame 37"), for: .normal)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(verifyButton)
        
        NSLayoutConstraint.activate([
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            verifyButton.topAnchor.constraint(equalTo: getNewCodeStackView.bottomAnchor, constant: padding)
        ])
    }
}
