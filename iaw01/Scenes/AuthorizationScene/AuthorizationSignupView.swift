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
    private let nameTextField: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure(){
        alpha = 0.0 
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(nameTextField)
    }
}
