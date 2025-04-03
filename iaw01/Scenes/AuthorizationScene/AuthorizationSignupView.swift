//
//  AuthorizationSignupView.swift
//  iaw01
//
//  Created by Дария Акатова on 29.03.2025.
//

import UIKit

//Во второй будут текстфилды name, номер телефона, создать пароль, вью регистрации через соцсети.
//То есть это отдельные вью, которые тут просто инитятся и добавляются в containerView, и переключаются через альфу.

class AuthorizationSignupView: UIStackView {
    
    private let socialButtons = AuthorizationSocialButtonsView()
    private let nameTextField = StringTextField(with: .nameStyle)
    private let createPasswordTextField = StringTextField(with: .createPasswordStyle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .vertical
        setupLayout()
    }
    
    private func setupLayout() {
        addArrangedSubview(nameTextField)
        addArrangedSubview(createPasswordTextField)
        addArrangedSubview(socialButtons)
        
        setCustomSpacing(26, after: nameTextField)
        setCustomSpacing(37, after: createPasswordTextField)
        
    }
}
