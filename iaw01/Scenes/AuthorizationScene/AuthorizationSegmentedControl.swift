//
//  AuthorizationSegmentedControl.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationSegmentedControl: UIView {
    
    enum Selection {
        case login
        case signUp
    }
    
    var toggleTextField: ((Selection) -> Void)?
    
    private let viewHeight: CGFloat = 63
    private let buttonHeight: CGFloat = 43
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        return button
    }
    
    private lazy var loginButton: UIButton = {
        let button = createButton(title: "Login")
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = createButton(title: "Sign Up")
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setupLayout()
        setupConstraints()
        
        updateButtonColors(selection: .login)
    }
    
    private func setupLayout() {
        backgroundColor = .pink60
        layer.cornerRadius = viewHeight / 2
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
        
    }
    
    @objc private func loginTapped() {
        toggleTextField?(.login)
        updateButtonColors(selection: .login)
    }
    
    @objc private func signUpTapped() {
        toggleTextField?(.signUp)
        updateButtonColors(selection: .signUp)
    }
    
    func updateButtonColors(selection: Selection) {
        
        switch selection {
        case .login:
                loginButton.backgroundColor = .pink100
                signUpButton.backgroundColor = .pink60
        case .signUp:
                loginButton.backgroundColor = .pink60
                signUpButton.backgroundColor = .pink100
        }
    }
}

extension AuthorizationSegmentedControl {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: viewHeight),            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            signUpButton.heightAnchor.constraint(equalToConstant: buttonHeight)
 
        ])
    }
}
