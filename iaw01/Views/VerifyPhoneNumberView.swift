//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {

    // UI-компоненты
    private lazy var verifyHeaderLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Verify Phone Number", font: .heading4)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verifyDescLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("We have sent you a 6 digit code. Please enter here to Verify your Number.", font: .body)
        label.textColor = UIColor(resource: .dark80)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.text = "+1 169 916 9564"
        textField.textColor = UIColor(resource: .dark90)
        textField.backgroundColor = UIColor.clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var containerViewForTextField: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(resource: .light80)
        container.layer.cornerRadius = 20
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var phoneEditButton: UIButton = {
        let button = UIButton()
        let buttonWidth: CGFloat = 39
        button.setImage(UIImage(named: "Frame 124"), for: .normal)
        button.backgroundColor = UIColor(resource: .peach60)
        button.layer.cornerRadius = buttonWidth / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var digitsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<6 {
            let textField = createTextField()
            codeDigits.append(textField)
            stack.addArrangedSubview(textField)
        }
        return stack
    }()
    
    private lazy var codeDigits: [UITextField] = []
    
    private lazy var getNewCodeStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var getNewCodeLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Didn't Receive Code?", font: .body)
        label.textColor = UIColor(resource: .dark80)
        return label
    }()
    
    private lazy var getNewCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.textColor = UIColor(resource: .pink100)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private lazy var attributedTitle: NSMutableAttributedString = {
        let attributedTitle = NSMutableAttributedString(string: "Get a New one")
        attributedTitle.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedTitle.length))
        return attributedTitle
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Frame 37"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

extension VerifyPhoneNumberView {
    private func setupViews() {
        addSubview(verifyHeaderLabel)
        addSubview(verifyDescLabel)
        addSubview(containerViewForTextField)
        addSubview(getNewCodeStackView)
        addSubview(phoneEditButton)
        addSubview(digitsStackView)
        addSubview(verifyButton)
        containerViewForTextField.addSubview(phoneNumberTextField)
        getNewCodeStackView.addArrangedSubview(getNewCodeLabel)
        getNewCodeStackView.addArrangedSubview(getNewCodeButton)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 21
        NSLayoutConstraint.activate([
            verifyHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            verifyHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            verifyDescLabel.topAnchor.constraint(equalTo: verifyHeaderLabel.bottomAnchor, constant: 10),
            verifyDescLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyDescLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            containerViewForTextField.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor, constant: padding),
            containerViewForTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            containerViewForTextField.heightAnchor.constraint(equalToConstant: 39),
            
            phoneNumberTextField.centerYAnchor.constraint(equalTo: containerViewForTextField.centerYAnchor),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: containerViewForTextField.leadingAnchor, constant: 10),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor, constant: -10),
            
            phoneEditButton.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor, constant: padding),
            phoneEditButton.leadingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor, constant: padding),
            phoneEditButton.heightAnchor.constraint(equalToConstant: 39),
            phoneEditButton.widthAnchor.constraint(equalToConstant: 39),
            phoneEditButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            digitsStackView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 45),
            digitsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            digitsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            digitsStackView.heightAnchor.constraint(equalToConstant: 58),
            
            getNewCodeStackView.topAnchor.constraint(equalTo: digitsStackView.bottomAnchor, constant: 60),
            getNewCodeStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            verifyButton.topAnchor.constraint(equalTo: getNewCodeStackView.bottomAnchor, constant: padding)
        ])
    }
}
