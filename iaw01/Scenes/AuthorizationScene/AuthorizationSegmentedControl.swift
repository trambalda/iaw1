//
//  AuthorizationSegmentedControl.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationSegmentedControl: UIView {
    
    private enum Constants {
        static let containerHeight: CGFloat = 63
        static let buttonHeight: CGFloat = 43
        static let containerCornerRadius: CGFloat = containerHeight / 2
        static let buttonCornerRadius: CGFloat = buttonHeight / 2
    }
    
    private  func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        return button
    }
    
    private lazy var loginButton: UIButton = createButton(title: "Login")
    private lazy var signUpButton: UIButton = createButton(title: "Sign Up")
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pink60
        view.layer.cornerRadius = Constants.containerCornerRadius
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
}

extension AuthorizationSegmentedControl {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 358),
            containerView.heightAnchor.constraint(equalToConstant: Constants.containerHeight),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            loginButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            signUpButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
}
