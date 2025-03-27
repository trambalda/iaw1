//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {
    
    private let constraintConstant: CGFloat = 39
    
    private var keyboardHeight: CGFloat = 0
    private var isKeyboardVisible = false
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    private var phoneEditButtonTrailingConstraint: NSLayoutConstraint!
    private var phoneNumberTextFieldIsActive = true

    private lazy var verifyHeaderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Verify Phone Number", color: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verifyDescLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("We have sent you a 6 digit code. Please enter here to Verify your Number.", color: nil)
        label.textColor = .dark80
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        button.setImage(.phoneEditButton, for: .normal)
        button.backgroundColor = .peach60
        button.layer.cornerRadius = buttonWidth / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var codeInputView: PincodeInputView = {
        let view = PincodeInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeDigits: [UITextField] = []
    
    private lazy var getNewCodeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var getNewCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Didn't Receive Code?", color: nil)
        label.textColor = .dark80
        return label
    }()
    
    private lazy var getNewCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.textColor = .pink100
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
        button.setImage(.verifyContinueButton, for: .normal)
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
            phoneEditButton.setImage(.checkmark, for: .normal)
            phoneEditButton.tintColor = .peach100
            phoneNumberTextField.isEnabled = true
            phoneNumberTextField.becomeFirstResponder()
            phoneEditButtonTrailingConstraint = phoneEditButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
            phoneEditButtonTrailingConstraint.isActive = true
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            phoneNumberTextFieldIsActive = false
        } else {
            phoneNumberTextField.resignFirstResponder()
            phoneEditButton.setImage(.phoneEditButton, for: .normal)
            phoneNumberTextField.isEnabled = false
            verifyButton.isHidden = false
            phoneNumberTextFieldIsActive = true
            phoneEditButtonTrailingConstraint.isActive = false
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.font = Font.subtitle1.font
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15
        textField.textColor = .dark100
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
        addSubview(codeInputView)
        addSubview(verifyButton)
        containerViewForTextField.addSubview(phoneNumberTextField)
        getNewCodeStackView.addArrangedSubview(getNewCodeLabel)
        getNewCodeStackView.addArrangedSubview(getNewCodeButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            verifyHeaderLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 21),
            verifyHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            verifyHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21),
            
            verifyDescLabel.topAnchor.constraint(equalTo: verifyHeaderLabel.bottomAnchor,constant: 10),
            verifyDescLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            verifyDescLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21),
            
            containerViewForTextField.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor,constant: 21),
            containerViewForTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            containerViewForTextField.heightAnchor.constraint(equalToConstant: constraintConstant),
            
            phoneNumberTextField.centerYAnchor.constraint(equalTo: containerViewForTextField.centerYAnchor),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: containerViewForTextField.leadingAnchor,constant: 10),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor,constant: -10),
            
            phoneEditButton.topAnchor.constraint(equalTo: verifyDescLabel.bottomAnchor,constant: 21),
            phoneEditButton.heightAnchor.constraint(equalToConstant: constraintConstant),
            phoneEditButton.widthAnchor.constraint(equalToConstant: constraintConstant),
            phoneEditButton.leadingAnchor.constraint(equalTo: containerViewForTextField.trailingAnchor,constant: 10),
            
            codeInputView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor,constant: 40),
            codeInputView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            codeInputView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21),
            codeInputView.heightAnchor.constraint(equalToConstant: 58),
            
            getNewCodeStackView.topAnchor.constraint(equalTo: codeInputView.bottomAnchor,constant: 10),
            getNewCodeStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21),
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -21)
        verifyButtonBottomConstraint.isActive = true
    }
}

// MARK: - UITextFieldDelegate
extension VerifyPhoneNumberView: UITextFieldDelegate{
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            let currentText = textField.text ?? "0"
            let newText = (currentText as NSString).replacingCharacters(
                in: range,
                with: string
            )
            return newText.count <= 1
        }
}

extension VerifyPhoneNumberView {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
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
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        keyboardHeight = keyboardFrame.height
        adjustButtonPositionForKeyboard(isShowing: true, notification: notification)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustButtonPositionForKeyboard(isShowing: false, notification: notification)
    }
    
    private func adjustButtonPositionForKeyboard(isShowing: Bool, notification: Notification) {
        let bottomPadding: CGFloat = isShowing ? -keyboardHeight : -21
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.verifyButtonBottomConstraint.constant = bottomPadding
            self.layoutIfNeeded()
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
