//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {
    
//    private let constraintConstant: CGFloat = 39
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    
    private lazy var labelsAndPhoneNumberTextFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 18
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var getNewCodeLabelAndButtonStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
    
    private lazy var phoneNumberInputView: PhoneNumberInputView = {
        let view = PhoneNumberInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pincodeInputView: PincodeInputView = {
        let view = PincodeInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var getNewCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Didn't Receive Code?", color: nil)
        label.textColor = .dark80
        return label
    }()
    
    private lazy var getNewCodeButton: LinkButton = {
        let button = LinkButton(style: .getNewCode)
        return button
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.setImage(.verifyContinueButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(verifyButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    func activatePincodeInput() {
        pincodeInputView.firstTextFieldBecomeFirstResponder()
    }
    
    @objc private func verifyButtonDidTapped() {
        phoneNumberInputView.resignFirstResponder()
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
        addSubview(labelsAndPhoneNumberTextFieldStackView)
        labelsAndPhoneNumberTextFieldStackView.addArrangedSubview(verifyHeaderLabel)
        labelsAndPhoneNumberTextFieldStackView.addArrangedSubview(verifyDescLabel)
        labelsAndPhoneNumberTextFieldStackView.addArrangedSubview(phoneNumberInputView)
        addSubview(getNewCodeLabelAndButtonStackView)
        getNewCodeLabelAndButtonStackView.addArrangedSubview(getNewCodeLabel)
        getNewCodeLabelAndButtonStackView.addArrangedSubview(getNewCodeButton)
        addSubview(pincodeInputView)
        addSubview(verifyButton)
        
        phoneNumberInputView.onVerifyButtonVisibilityChanged = { [weak self] hide in
            UIView.animate(withDuration: 0.3) {
                self?.verifyButton.isHidden = hide
                self?.layoutIfNeeded()
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelsAndPhoneNumberTextFieldStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21),
            labelsAndPhoneNumberTextFieldStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 21),
            labelsAndPhoneNumberTextFieldStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -21),
            
            pincodeInputView.topAnchor.constraint(equalTo: labelsAndPhoneNumberTextFieldStackView.bottomAnchor, constant: 44),
            pincodeInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            pincodeInputView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            pincodeInputView.heightAnchor.constraint(equalToConstant: 58),
            
            getNewCodeLabelAndButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            getNewCodeLabelAndButtonStackView.topAnchor.constraint(equalTo: pincodeInputView.bottomAnchor, constant: 45),
            
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21)
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -95)
        verifyButtonBottomConstraint.isActive = true
    }
}

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
        NotificationCenter.registerKeyboardNotifications(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification)
        
        NotificationCenter.registerKeyboardNotifications(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification)
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.unregisterKeyboardNotifications(
            self,
            name: UIResponder.keyboardWillShowNotification)
        
        NotificationCenter.unregisterKeyboardNotifications(
            self,
            name: UIResponder.keyboardDidHideNotification)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
    
        let bottomPadding: CGFloat = -keyboardFrame.height + (-15)
        changeVerifyButtonPosition(isShowing: true, notification: notification, bottomPadding: bottomPadding)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let bottomPadding: CGFloat = -100
        changeVerifyButtonPosition(isShowing: false, notification: notification, bottomPadding: bottomPadding)
    }
    
    private func changeVerifyButtonPosition(isShowing: Bool, notification: Notification, bottomPadding: CGFloat) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.verifyButtonBottomConstraint.constant = bottomPadding
            self.layoutIfNeeded()
        }
    }
}
