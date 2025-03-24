//
//  AuthorizationSegmentedControl.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationSegmentedControl: UIView {
    
    var toggleTextField: ((Bool) -> Void)?
    
    private let containerHeight: CGFloat = 63
    private let buttonHeight: CGFloat = 43
    
    private  func createButton(title: String) -> UIButton {
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
    
    private lazy var  containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pink60
        view.layer.cornerRadius = containerHeight / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        configure()
    }
    
    private func configure() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
    }
    
    @objc private func loginTapped() {
        toggleTextField?(true)
        updateButtonColors(isLogin: true)
    }
    
    @objc private func signUpTapped() {
        toggleTextField?(false)
        updateButtonColors(isLogin: false)
    }
    
    func updateButtonColors(isLogin: Bool) {
        if isLogin {
            loginButton.backgroundColor = .pink100
            signUpButton.backgroundColor = .pink60
        } else {
            loginButton.backgroundColor = .pink60
            signUpButton.backgroundColor = .pink100
        }
    }
}

extension AuthorizationSegmentedControl {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 358),
            containerView.heightAnchor.constraint(equalToConstant: containerHeight),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            loginButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            signUpButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
}
