//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {
    
    private let padding: CGFloat = 21
    private let additionalOffset: CGFloat = 35
    
    private var keyboardHeight: CGFloat = 0
    private var isKeyboardVisible = false
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    private var phoneNumberTextFieldTrailingConstraint: NSLayoutConstraint!
    private var phoneNumberTextFieldIsActive = true

    private lazy var verifyHeaderLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Verify Phone Number", font: .heading4)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verifyDescLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont(
            "We have sent you a 6 digit code. Please enter here to Verify your Number.",
            font: .body
        )
        label.textColor = UIColor(resource: .dark80)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.keyboardType = .numberPad
        textField.text = "+1 169 916 9564"
        textField.textColor = UIColor(resource: .dark90)
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var containerViewForTextField: UIView = {
        let container = UIView()
        container.backgroundColor = .light80
        container.layer.cornerRadius = 20
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var phoneEditButton: UIButton = {
        let button = UIButton()
        let buttonWidth: CGFloat = 39
        button.setImage(UIImage(named: "phoneEditButton"), for: .normal)
        button.backgroundColor = .peach60
        button.layer.cornerRadius = buttonWidth / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
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
            
            textField.delegate = self
            
            textField.addTarget(
                self,
                action: #selector(textFieldDidChange(_:)),
                for: .editingChanged
            )
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
        button.setImage(UIImage(named: "verifyContinueButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(verifyButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, text.count == 1 else { return }

        if let nextTextField = codeDigits[safe: textField.tag + 1] {
                nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    @objc private func verifyButtonDidTapped() {
        phoneNumberTextField.resignFirstResponder()
    }
    
    @objc private func editButtonDidTapped() {
        if phoneNumberTextFieldIsActive {
            verifyButton.isHidden = true
            phoneEditButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            phoneEditButton.tintColor = UIColor(resource: .peach100)
            phoneNumberTextField.isEnabled = true
            phoneNumberTextField.becomeFirstResponder()
            phoneNumberTextFieldTrailingConstraint = containerViewForTextField.trailingAnchor.constraint(
                equalTo: phoneEditButton.leadingAnchor,
                constant: -padding
            )
            phoneNumberTextFieldTrailingConstraint.isActive = true
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            phoneNumberTextFieldIsActive = false
        } else {
            phoneNumberTextField.resignFirstResponder()
            phoneEditButton.setImage(UIImage(named: "phoneEditButton"), for: .normal)
            phoneNumberTextField.isEnabled = false
            verifyButton.isHidden = false
            phoneNumberTextFieldIsActive = true
            phoneNumberTextFieldTrailingConstraint.isActive = false
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.font = Font.subtitle1
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.textColor = UIColor(resource: .dark100)
        textField.backgroundColor = .light80
        return textField
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        registerForKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        unregisterFromKeyboardNotifications()
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
        
        NSLayoutConstraint.activate([
            verifyHeaderLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: padding
            ),
            verifyHeaderLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding
            ),
            verifyHeaderLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding
            ),
            
            verifyDescLabel.topAnchor.constraint(
                equalTo: verifyHeaderLabel.bottomAnchor,
                constant: 10
            ),
            verifyDescLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding
            ),
            verifyDescLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding
            ),
            
            containerViewForTextField.topAnchor.constraint(
                equalTo: verifyDescLabel.bottomAnchor,
                constant: padding
            ),
            containerViewForTextField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding
            ),
            containerViewForTextField.heightAnchor.constraint(
                equalToConstant: 39
            ),
            
            
            phoneNumberTextField.centerYAnchor.constraint(
                equalTo: containerViewForTextField.centerYAnchor),
            phoneNumberTextField.leadingAnchor.constraint(
                equalTo: containerViewForTextField.leadingAnchor,
                constant: 10
            ),
            phoneNumberTextField.trailingAnchor.constraint(
                equalTo: containerViewForTextField.trailingAnchor,
                constant: -10
            ),
            
            phoneEditButton.topAnchor.constraint(
                equalTo: verifyDescLabel.bottomAnchor,
                constant: padding),
            phoneEditButton.heightAnchor.constraint(
                equalToConstant: 39
            ),
            phoneEditButton.widthAnchor.constraint(
                equalToConstant: 39
            ),
            phoneEditButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding
            ),
            
            digitsStackView.topAnchor.constraint(
                equalTo: phoneNumberTextField.bottomAnchor,
                constant: 40
            ),
            digitsStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding
            ),
            digitsStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding
            ),
            digitsStackView.heightAnchor.constraint(
                equalToConstant: 58
            ),
            
            getNewCodeStackView.topAnchor.constraint(
                equalTo: digitsStackView.bottomAnchor,
                constant: 10
            ),
            getNewCodeStackView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            
            verifyButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding
            ),
            verifyButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding
            ),
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor,
            constant: -padding
        )
        verifyButtonBottomConstraint.isActive = true
    }
}

// MARK: - UITextFieldDelegate
extension VerifyPhoneNumberView: UITextFieldDelegate{
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(
                in: range,
                with: string
            )
            return newText.count <= 1
        }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension VerifyPhoneNumberView {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                CGRect else { return }
        
        keyboardHeight = keyboardFrame.height
        
        adjustButtonPositionForKeyboard(isShowing: true, notification: notification)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustButtonPositionForKeyboard(isShowing: false, notification: notification)
    }
    
    private func adjustButtonPositionForKeyboard(isShowing: Bool, notification: Notification) {
        let safeAreaBottomInset = safeAreaInsets.bottom
        let bottomPadding: CGFloat = isShowing ? -(keyboardHeight - safeAreaBottomInset - additionalOffset) : -padding
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.verifyButtonBottomConstraint.constant = bottomPadding
            self.layoutIfNeeded()
        }
    }
}
