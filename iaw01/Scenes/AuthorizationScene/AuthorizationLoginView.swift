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
    
    private let emailTextField: StringTextField = {
        let textField = StringTextField(with: .emailStyle)
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
        setupLayout()
    }
    
    private func setupLayout() {
        addArrangedSubview(emailTextField)
    }
}
