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
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    
    private lazy var labelsAndPhoneNumberTextFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var pinCodeInputAndGetNewCodeLabelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 30
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var getNewCodeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 1
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
        addSubview(pinCodeInputAndGetNewCodeLabelsStackView)
        pinCodeInputAndGetNewCodeLabelsStackView.addArrangedSubview(pincodeInputView)
        getNewCodeStackView.addArrangedSubview(getNewCodeLabel)
        getNewCodeStackView.addArrangedSubview(getNewCodeButton)
        pinCodeInputAndGetNewCodeLabelsStackView.addArrangedSubview(getNewCodeStackView)
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
            
            pincodeInputView.heightAnchor.constraint(equalToConstant: 58),
            
            pinCodeInputAndGetNewCodeLabelsStackView.topAnchor.constraint(equalTo: labelsAndPhoneNumberTextFieldStackView.bottomAnchor, constant: 30),
            pinCodeInputAndGetNewCodeLabelsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 21),
            pinCodeInputAndGetNewCodeLabelsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -21),
            
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 21),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -21)
//            verifyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -21)
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -21)
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
