//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {
    
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    
    private var tabBarHeight: CGFloat {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController
        else { return 0 }
        
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.tabBar.frame.height + rootViewController.view.safeAreaInsets.bottom
        }
        return rootViewController.view.safeAreaInsets.bottom
    }
    
    private lazy var labelsAndPhoneNumberTextFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 18
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
    
    private var getNewCodeButton = LinkButton(style: .getNewCode)
    
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
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self, name: UIResponder.keyboardWillShowNotification)
        NotificationCenter.unregisterKeyboardNotifications(self, name: UIResponder.keyboardDidHideNotification)
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
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -tabBarHeight)
        verifyButtonBottomConstraint.isActive = true
    }
}

extension VerifyPhoneNumberView: UITextFieldDelegate{
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String
    ) -> Bool {
        string.count <= 1
    }
}

extension VerifyPhoneNumberView {
    private func setupObservers() {
        NotificationCenter.registerKeyboardNotifications(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification)
        NotificationCenter.registerKeyboardNotifications(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
    
        let bottomPadding: CGFloat = -keyboardFrame.height
        changeVerifyButtonPosition(notification: notification, bottomPadding: bottomPadding)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let bottomPadding: CGFloat = -tabBarHeight
        changeVerifyButtonPosition(notification: notification, bottomPadding: bottomPadding)
    }
    
    private func changeVerifyButtonPosition(notification: Notification, bottomPadding: CGFloat) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.verifyButtonBottomConstraint.constant = bottomPadding
            self.layoutIfNeeded()
        }
    }
}
