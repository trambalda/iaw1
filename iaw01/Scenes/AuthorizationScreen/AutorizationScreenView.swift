//
//  AutorizationScreenView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import Foundation
import UIKit

class AutorizationScreenView: UIView {
    
    //    MARK: Lables (верхник лейблы в стеке)
    
    private lazy var stackViewLables: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [autorizationHeadLabel, autorizationDescriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private var autorizationHeadLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.setTextAndFont("Welcome!", font: .heading4)
        headLabel.textColor = .dark100
        return headLabel
    }()
    
    private var autorizationDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.setTextAndFont("Sign up or Login to your Account", font: .body)
        descriptionLabel.textColor = .dark80
        return descriptionLabel
    }()
    
    //    MARK: кнопки в контейнере
    private lazy var containerViewForButtons: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 253/255, green: 211/255, blue: 211/255, alpha: 0.4)
        view.layer.cornerRadius = 35
        return view
    }()
    
    private lazy var stackViewButtonsInContainer: UIStackView = {
        let stackViewInContainer = UIStackView(arrangedSubviews: [LoginButtonInContainer, SingUpButtonInContainer])
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 10
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .center
        return stackViewInContainer
    }()
    
    private func createLoginAndSingUpButtonInContainer(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }
    
    private lazy var LoginButtonInContainer: UIButton = createLoginAndSingUpButtonInContainer(title: "Login")
    private lazy var SingUpButtonInContainer: UIButton = createLoginAndSingUpButtonInContainer(title: "Sign Up")
    
    // MARK: Email Address and Password
//    общий UIStackView
    private lazy var stackViewEmailAddressAndPassword: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewEmailAddress, stackViewPassword])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 26
        return stackView
    }()
    
//    EmailAddress
    private lazy var stackViewEmailAddress: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailAddressLabel, emailTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Email Address", font: .body)
        label.textColor = .dark100
        return label
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
//  Password
    
    private lazy var stackViewPassword: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Password", font: .body)
        label.textColor = .dark100
        return label
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your Password"
        textField.borderStyle = .roundedRect
        //            textField.isSecureTextEntry = true
        return textField
    }()
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureOfScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureOfScreen() {
        backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        setupConstraintsLabels()
        setupConstraintsButtonsInConteiner()
    }
    
    
    
}

// MARK: - Layout

extension AutorizationScreenView {
    
    private func setupConstraintsLabels() {
        addSubview(stackViewLables)
        
        stackViewLables.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewLables.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21),
            stackViewLables.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
    }
    
    private func setupConstraintsButtonsInConteiner() {
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
            stackViewButtonsInContainer.heightAnchor.constraint(equalToConstant: 43)
            
        ])
    }
    
    private func setupConstraintsForstackViewEmailAddressAndPassword() {
        addSubview(stackViewEmailAddressAndPassword)
        
        stackViewEmailAddressAndPassword.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}



