//
//  AuthorizationView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AuthorizationView: UIView {
    
    private let stackView = UIStackView()
    private let titleView = AuthorizationTitleView()
    private let segmentedControl = AuthorizationSegmentedControl()
    private let socialLoginView = AuthorizationSocialNetworkButtonsView()
    
    private let containerView = UIView()
    private let loginView = UIView()
    private let signupView = UIView()
    private let emailTextField = StringTextField(with: .emailStyle)
    private let nameTextField = StringTextField(with: .nameStyle)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        setupButtonAction()
    }
    
    private func setupButtonAction() {
        segmentedControl.toggleTextField = { [weak self] selection in
            self?.switchView(to: selection)
        }
    }
    
    private func switchView(to selection: AuthorizationSegmentedControl.Selection) {
        let fromView = selection == .login ? signupView : loginView
        let toView = selection == .login ? loginView : signupView
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        })
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(loginView)
        containerView.addSubview(signupView)
        stackView.addArrangedSubview(socialLoginView)
        
        setupTextField(textField: emailTextField, in: loginView)
        setupTextField(textField: nameTextField, in: signupView)
        signupView.alpha = 0.0
        stackView.setCustomSpacing(21, after: titleView)
        stackView.setCustomSpacing(24, after: segmentedControl)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        signupView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTextField(textField: StringTextField, in view: UIView) {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            loginView.topAnchor.constraint(equalTo: containerView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            signupView.topAnchor.constraint(equalTo: containerView.topAnchor),
            signupView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signupView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}


