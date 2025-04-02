//
//  VerifyPhoneNumberView.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberView: UIView {
    
    private var verifyButtonBottomConstraint: NSLayoutConstraint!
    private var keyboardPadding: CGFloat = 16
    private var getNewCodeButton = LinkButton(style: .getNewCode)
    
    //TODO: подрефачить после создания таббара (строки 143, 173)
//    private var tabBarHeight: CGFloat {
//        guard
//            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let rootViewController = windowScene.windows.first?.rootViewController
//        else { return 0 }
//        
//        if let tabBarController = rootViewController as? UITabBarController {
//            return tabBarController.tabBar.frame.height
//        }
//        return rootViewController.view.safeAreaInsets.bottom
//    }
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var verifyHeaderLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.heading4.compose("Verify Phone Number", color: nil)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var verifyDescLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("We have sent you a 6 digit code. Please enter here to Verify your Number.", color: nil)
        label.textColor = .dark80
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var phoneNumberInputView: PhoneNumberInputView = {
        let view = PhoneNumberInputView()
        return view
    }()
    
    private lazy var pincodeInputView: PincodeInputView = {
        let view = PincodeInputView()
        return view
    }()
    
    private lazy var getNewCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("Didn't Receive Code?", color: nil)
        label.textColor = .dark80
        return label
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
        setupLayout()
        setupConstraints()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.unregisterKeyboardNotifications(self)
    }
}

extension VerifyPhoneNumberView {
    private func setupLayout() {
        let newCodeOuterStackView = UIStackView()
        newCodeOuterStackView.axis = .vertical
        newCodeOuterStackView.alignment = .center
        let newCodeInnerStackView = UIStackView()
        newCodeInnerStackView.spacing = 5
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(verifyHeaderLabel)
        mainStackView.addArrangedSubview(verifyDescLabel)
        mainStackView.addArrangedSubview(phoneNumberInputView)
        mainStackView.addArrangedSubview(pincodeInputView)
        mainStackView.addArrangedSubview(newCodeOuterStackView)
        newCodeOuterStackView.addArrangedSubview(newCodeInnerStackView)
        newCodeInnerStackView.addArrangedSubview(getNewCodeLabel)
        newCodeInnerStackView.addArrangedSubview(getNewCodeButton)
        addSubview(verifyButton)
        
        phoneNumberInputView.onVerifyButtonVisibilityChanged = { [weak self] isHidden in
            UIView.animate(withDuration: 0.3) {
                self?.verifyButton.isHidden = isHidden
                self?.layoutIfNeeded()
            }
        }
        
        mainStackView.setCustomSpacing(Constans.isSE ? 20 : 40, after: phoneNumberInputView)
        mainStackView.setCustomSpacing(Constans.isSE ? 20 : 40, after: pincodeInputView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 21),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -21),
            
            pincodeInputView.heightAnchor.constraint(equalToConstant: 55),
            
            verifyButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            verifyButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16)
        ])
        verifyButtonBottomConstraint = verifyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(Constans.isSE ? 49 : 83 + keyboardPadding))
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
        NotificationCenter.registerKeyboardNotifications(self, willShowSelector: #selector(keyboardWillShow), willHideSelector: #selector(keyboardWillHide))
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
    
        let bottomPadding: CGFloat = -(keyboardFrame.height + keyboardPadding)
        changeVerifyButtonPosition(notification: notification, bottomPadding: bottomPadding)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let bottomPadding: CGFloat = -(Constans.isSE ? 49 : 83 + keyboardPadding)
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
