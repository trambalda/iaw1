//
//  AuthorizationLoginView.swift
//  iaw01
//
//  Created by Дария Акатова on 29.03.2025.
//

import UIKit

//В первой будут текстфилды емайл, пароль, кнока забыл пароль, вью авторизации через соцсети.
//То есть это отдельные вью, которые тут просто инитятся и добавляются в containerView, и переключаются через альфу.

class AuthorizationLoginView: UIStackView {
    
    private let emailTextField = StringTextField(with: .emailStyle)
    private let passwordTextField = StringTextField(with: .passwordStyle)
    
    private let forgotLinkingButton: LinkButton = {
        let button = LinkButton(style: .forgotPassword)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setupStackView()
        setupLayout()
        setupConstraints()
    }
    
    private func setupStackView() {
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        addArrangedSubview(emailTextField)
        addArrangedSubview(passwordTextField)
        forgotContainerView.addSubview(forgotLinkingButton)
        addArrangedSubview(forgotContainerView)
        
        setCustomSpacing(26, after: emailTextField)
        setCustomSpacing(15, after: passwordTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            forgotLinkingButton.trailingAnchor.constraint(equalTo: forgotContainerView.trailingAnchor),
            forgotLinkingButton.topAnchor.constraint(equalTo: forgotContainerView.topAnchor),
            forgotLinkingButton.bottomAnchor.constraint(equalTo: forgotContainerView.bottomAnchor),
            
            forgotLinkingButton.leadingAnchor.constraint(greaterThanOrEqualTo: forgotContainerView.leadingAnchor),
            forgotLinkingButton.heightAnchor.constraint(equalToConstant: 23),
        ])
    }
}
