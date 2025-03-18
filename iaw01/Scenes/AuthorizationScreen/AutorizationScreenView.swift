//
//  AutorizationScreenView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import Foundation
import UIKit

class AutorizationScreenView: UIView {
    
    //    MARK: Lables (Welcome и текст)
    //  IU компоненты
    
    private lazy var stackViewLables: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [autorizationHeadLabel, autorizationDescriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private func createLabel(text: String, font: Font.Name, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.setTextAndFont(text, font: font)
        label.textColor = textColor
        return label
    }
    
    // UI элементы
    
    private lazy var autorizationHeadLabel: UILabel =
    createLabel(text: "Welcome!", font: .heading4, textColor: .dark100)
    
    private lazy var autorizationDescriptionLabel: UILabel =
    createLabel(text: "Sign up or Login to your Account", font: .body, textColor: .dark80)
    
    
    //    MARK: кнопки (Login и Sign up) в контейнере
    
    private lazy var containerViewForButtons: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 253/255, green: 211/255, blue: 211/255, alpha: 0.4)
        view.layer.cornerRadius = 35
        return view
    }()
    
    private lazy var stackViewButtonsInContainer: UIStackView = {
        let stackViewInContainer = UIStackView(arrangedSubviews: [LoginButtonInContainer, SignUpButtonInContainer])
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 10
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .center
        return stackViewInContainer
    }()
    
    private func createLoginAndSignUpButtonInContainer(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }
    
    private lazy var LoginButtonInContainer: UIButton = createLoginAndSignUpButtonInContainer(title: "Login")
    private lazy var SignUpButtonInContainer: UIButton = createLoginAndSignUpButtonInContainer(title: "Sign Up")
    
    
    // MARK: TextFields для реализации Buttons
    //    IU компоненты
    
    private func createLabelForFieldsforEnteringUserData(text: String) -> UILabel {
        let label = UILabel()
        label.setTextAndFont(text, font: .body)
        label.textColor = .dark100
        return label
    }
    
    private func createTextFieldForFieldsforEnteringUserData(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .light80
        return textField
    }
    
    private func createStackViewForFieldsforEnteringUserData(arrangedSubviews: [UIView], spacing: CGFloat = 6) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = spacing
        return stackView
    }
    
    // UI элементы
    
    private lazy var emailAddressLabel: UILabel = createLabelForFieldsforEnteringUserData(text: "Email Address")
    private lazy var emailTextField: UITextField = createTextFieldForFieldsforEnteringUserData(placeholder: "Enter your Email")
    
    private lazy var passwordLabel: UILabel = createLabelForFieldsforEnteringUserData(text: "Password")
    private lazy var passwordTextField: UITextField = createTextFieldForFieldsforEnteringUserData(placeholder: "Enter your Password")
    
    private lazy var fullNameLable: UILabel = createLabelForFieldsforEnteringUserData(text: "Full Name")
    private lazy var fullNameTextField: UITextField = createTextFieldForFieldsforEnteringUserData(placeholder: "Enter your Name")
    
    private lazy var phoneNumberLable: UILabel = createLabelForFieldsforEnteringUserData(text: "Phone Number")
    private lazy var phoneNumberTextField: UITextField = createTextFieldForFieldsforEnteringUserData(placeholder: "Number")
    
    private lazy var creatingPasswordLable: UILabel = createLabelForFieldsforEnteringUserData(text: "Create Password")
    private lazy var creatingPasswordTextField: UITextField = createTextFieldForFieldsforEnteringUserData(placeholder: "Enter your Password")
    
    private lazy var stackViewEmailAddress: UIStackView = createStackViewForFieldsforEnteringUserData(arrangedSubviews: [emailAddressLabel, emailTextField])
    private lazy var stackViewPassword: UIStackView = createStackViewForFieldsforEnteringUserData(arrangedSubviews: [passwordLabel, passwordTextField])
    
    private lazy var stackViewFullName: UIStackView = createStackViewForFieldsforEnteringUserData(arrangedSubviews: [fullNameLable, fullNameTextField])
    private lazy var stackViewPhoneNumber: UIStackView = createStackViewForFieldsforEnteringUserData(arrangedSubviews: [phoneNumberLable, phoneNumberTextField])
    private lazy var stackViewCreatingPassword: UIStackView = createStackViewForFieldsforEnteringUserData(arrangedSubviews: [creatingPasswordLable, creatingPasswordTextField])
    
    
    private lazy var stackViewEmailAddressAndPassword: UIStackView = createStackViewForFieldsforEnteringUserData(
        arrangedSubviews: [stackViewEmailAddress, stackViewPassword],
        spacing: 26)
    
    private lazy var stackViewFullNamePhoneNumberAndCreatingPassword: UIStackView = createStackViewForFieldsforEnteringUserData(
        arrangedSubviews: [stackViewFullName, stackViewPhoneNumber, stackViewCreatingPassword],
        spacing: 26)
    
    
    @objc private func toggleAuthMode(_ sender: UIButton) {
        let isLoginSelected = sender == LoginButtonInContainer
        
       
        LoginButtonInContainer.backgroundColor = isLoginSelected ? .pink100 : containerViewForButtons.backgroundColor
        SignUpButtonInContainer.backgroundColor = isLoginSelected ? containerViewForButtons.backgroundColor : .pink100
        
        stackViewEmailAddressAndPassword.isHidden = !isLoginSelected
        stackViewFullNamePhoneNumberAndCreatingPassword.isHidden = isLoginSelected
    }
    
    
    
    //    MARK: Forgot Password
    
    private lazy var forgotPasswordLable: UILabel = {
        let lable = UILabel()
        lable.setTextAndFont("Forgot Password?", font: .body)
        lable.textColor = .dark80
        return lable
    }()
    
    //    MARK: Or Login Using
    
    private lazy var loginUsingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginUsingLable, lineContainerView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var loginUsingLable: UILabel = createLabel(text: "Or Login Using:", font: .body, textColor: .dark80)
    
    let lineViewNearWithLoginUsing: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .light60
        return lineView
    }()
    
    private lazy var lineContainerView: UIView = {
        let view = UIView()
        view.addSubview(lineViewNearWithLoginUsing)
        return view
    }()
    
    
//    MARK: social network
    
    
    private lazy var stackViewSocialNetworkButton: UIStackView = {
        let stackViewInContainer = UIStackView(arrangedSubviews: [googleButton, appleButton])
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 20
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .leading
        return stackViewInContainer
    }()
    
    private func createSocialNetworkButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35.5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.light60.cgColor
        button.clipsToBounds = true
        
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        
        return button
    }
    
    private lazy var googleButton = createSocialNetworkButton(imageName: "googleLogo")
    private lazy var appleButton = createSocialNetworkButton(imageName: "appleLogo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfScreen()
        
        LoginButtonInContainer.addTarget(self, action: #selector(toggleAuthMode(_:)), for: .touchUpInside)
        SignUpButtonInContainer.addTarget(self, action: #selector(toggleAuthMode(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureOfScreen() {
        backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        setupConstraintsLabels()
        setupConstraintsButtonsInContainer()
        setupConstraintsForStackViewEmailAddressAndPassword()
        setupConstraintsForForgotPasswordLable()
        setupConstraintsForLoginUsingStackView()
        setupConstraintsForstackViewSocialNetworkButton()
    }
    
    
}

// MARK: - Layout

extension AutorizationScreenView {
    
    private func setupConstraintsLabels() {
        addSubview(stackViewLables)
        
        stackViewLables.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewLables.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackViewLables.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
    }
    
    private func setupConstraintsButtonsInContainer() {
        addSubview(containerViewForButtons)
        containerViewForButtons.addSubview(stackViewButtonsInContainer)
        
        containerViewForButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtonsInContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerViewForButtons.topAnchor.constraint(equalTo: stackViewLables.bottomAnchor, constant: 21),
            containerViewForButtons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerViewForButtons.widthAnchor.constraint(equalToConstant: 358),
            containerViewForButtons.heightAnchor.constraint(equalToConstant: 63),
            
            stackViewButtonsInContainer.centerXAnchor.constraint(equalTo: containerViewForButtons.centerXAnchor),
            stackViewButtonsInContainer.centerYAnchor.constraint(equalTo: containerViewForButtons.centerYAnchor),
            stackViewButtonsInContainer.leadingAnchor.constraint(equalTo: containerViewForButtons.leadingAnchor, constant: 16),
            stackViewButtonsInContainer.trailingAnchor.constraint(equalTo: containerViewForButtons.trailingAnchor, constant: -16),
            stackViewButtonsInContainer.heightAnchor.constraint(equalToConstant: 43),
            
            LoginButtonInContainer.heightAnchor.constraint(equalToConstant: 43),
            SignUpButtonInContainer.heightAnchor.constraint(equalToConstant: 43)
            
        ])
    }
    
    private func setupConstraintsForStackViewEmailAddressAndPassword() {
        addSubview(stackViewEmailAddressAndPassword)
        addSubview(stackViewFullNamePhoneNumberAndCreatingPassword)
        
        stackViewEmailAddressAndPassword.translatesAutoresizingMaskIntoConstraints = false
        stackViewFullNamePhoneNumberAndCreatingPassword.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewEmailAddressAndPassword.topAnchor.constraint(equalTo: containerViewForButtons.bottomAnchor, constant: 24),
            stackViewEmailAddressAndPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackViewEmailAddressAndPassword.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 51),
            passwordTextField.heightAnchor.constraint(equalToConstant: 51),
            
            stackViewFullNamePhoneNumberAndCreatingPassword.topAnchor.constraint(equalTo: containerViewForButtons.bottomAnchor, constant: 24),
            stackViewFullNamePhoneNumberAndCreatingPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackViewFullNamePhoneNumberAndCreatingPassword.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            fullNameTextField.heightAnchor.constraint(equalToConstant: 51),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 51),
            creatingPasswordTextField.heightAnchor.constraint(equalToConstant: 51)
        ])
    }
    
    private func setupConstraintsForForgotPasswordLable() {
        addSubview(forgotPasswordLable)
        
        forgotPasswordLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forgotPasswordLable.topAnchor.constraint(equalTo: stackViewEmailAddressAndPassword.bottomAnchor, constant: 15),
            forgotPasswordLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            forgotPasswordLable.widthAnchor.constraint(equalToConstant: 137),
            forgotPasswordLable.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
    
    private func setupConstraintsForLoginUsingStackView() {
        addSubview(loginUsingStackView)
        
        loginUsingStackView.translatesAutoresizingMaskIntoConstraints = false
        lineViewNearWithLoginUsing.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            loginUsingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginUsingStackView.topAnchor.constraint(equalTo: forgotPasswordLable.bottomAnchor, constant: 38),
            loginUsingStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            loginUsingStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            lineViewNearWithLoginUsing.centerYAnchor.constraint(equalTo: lineContainerView.centerYAnchor),
            lineViewNearWithLoginUsing.leadingAnchor.constraint(equalTo: lineContainerView.leadingAnchor),
            lineViewNearWithLoginUsing.trailingAnchor.constraint(equalTo: lineContainerView.trailingAnchor),
            lineViewNearWithLoginUsing.heightAnchor.constraint(equalToConstant: 1)
            
            
        ])
    }
    
    private func setupConstraintsForstackViewSocialNetworkButton() {
        addSubview(stackViewSocialNetworkButton)
        
        stackViewSocialNetworkButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewSocialNetworkButton.topAnchor.constraint(equalTo: loginUsingStackView.bottomAnchor, constant: 28),
            stackViewSocialNetworkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            
            googleButton.widthAnchor.constraint(equalToConstant: 71),
            googleButton.heightAnchor.constraint(equalToConstant: 71),
            
            appleButton.widthAnchor.constraint(equalToConstant: 71),
            appleButton.heightAnchor.constraint(equalToConstant: 71)
            
        ])
    }
    
    
}


