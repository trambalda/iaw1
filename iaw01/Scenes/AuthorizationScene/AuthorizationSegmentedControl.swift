//
//  AuthorizationSegmentedControl.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationSegmentedControl: UIView {
    
    private  func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = 43 / 2
        return button
    }
  
    private lazy var loginButton: UIButton = createButton(title: "Login")
    private lazy var signUpButton: UIButton = createButton(title: "Sign Up")
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pink60
//        Если высота 63 (или выше, кнопки 43) фигурирует в констрейнтах, то есть упоминается в разных местах класса, удобнее вынести это в константы.
        view.layer.cornerRadius = 63 / 2
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackViewInContainer = UIStackView()
//        Дефолтное значение не нужно указывать
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 10
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .center
        return stackViewInContainer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
    }
}

extension AuthorizationSegmentedControl {
    private func setupConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
//            нужно установить topAnchor.constraint(equalTo: stackViewLabels.bottomAnchor, constant: 21), не знаю, как реализовать
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 137),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 358),
            containerView.heightAnchor.constraint(equalToConstant: 63),
            
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 43),
            
            loginButton.heightAnchor.constraint(equalToConstant: 43),
            signUpButton.heightAnchor.constraint(equalToConstant: 43),
        ])
    }
}
