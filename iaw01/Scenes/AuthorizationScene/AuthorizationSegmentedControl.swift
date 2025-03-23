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
        view.layer.cornerRadius = 63 / 2
        return view
    }()
    
    private let stackViewButtonsInContainer: UIStackView = {
        let stackViewInContainer = UIStackView()
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 10
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .center
        return stackViewInContainer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutButtonView()
        setupConstraintsButtons()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupLayoutButtonView() {
        addSubview(containerView)
        containerView.addSubview(stackViewButtonsInContainer)
        stackViewButtonsInContainer.addArrangedSubview(loginButton)
        stackViewButtonsInContainer.addArrangedSubview(signUpButton)
        
    }
}

// MARK: - Constraints

extension AuthorizationSegmentedControl {
    private func setupConstraintsButtons() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtonsInContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
//            нужно установить topAnchor.constraint(equalTo: stackViewLabels.bottomAnchor, constant: 21), не знаю, как реализовать
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 137),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 358),
            containerView.heightAnchor.constraint(equalToConstant: 63),
            
            stackViewButtonsInContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackViewButtonsInContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackViewButtonsInContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackViewButtonsInContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackViewButtonsInContainer.heightAnchor.constraint(equalToConstant: 43),
            
            loginButton.heightAnchor.constraint(equalToConstant: 43),
            signUpButton.heightAnchor.constraint(equalToConstant: 43),
            
            
        ])
    }
    
}
