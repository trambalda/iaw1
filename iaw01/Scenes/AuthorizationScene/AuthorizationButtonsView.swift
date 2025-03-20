//
//  AuthorizationButtonsView.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationButtonsView: UIView {
    
    private static func createLoginAndSignUpButtons(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .pink100
        button.setTitle(title, for: .normal)
        button.setTitleColor(.light100, for: .normal)
        button.layer.cornerRadius = 43 / 2
        return button
    }
  
    private let LoginButton: UIButton = createLoginAndSignUpButtons(title: "Login")
    private let SignUpButton: UIButton = createLoginAndSignUpButtons(title: "Sign Up")
    
    
    private let containerViewForButtons: UIView = {
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
        addSubview(containerViewForButtons)
        containerViewForButtons.addSubview(stackViewButtonsInContainer)
        stackViewButtonsInContainer.addArrangedSubview(LoginButton)
        stackViewButtonsInContainer.addArrangedSubview(SignUpButton)
        
    }
}

// MARK: - Constraints

extension AuthorizationButtonsView {
    private func setupConstraintsButtons() {
        
        containerViewForButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtonsInContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
//            нужно установить topAnchor.constraint(equalTo: stackViewLabels.bottomAnchor, constant: 21), не знаю, как реализовать
            containerViewForButtons.topAnchor.constraint(equalTo: topAnchor, constant: 137),
            containerViewForButtons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerViewForButtons.widthAnchor.constraint(equalToConstant: 358),
            containerViewForButtons.heightAnchor.constraint(equalToConstant: 63),
            
            stackViewButtonsInContainer.centerXAnchor.constraint(equalTo: containerViewForButtons.centerXAnchor),
            stackViewButtonsInContainer.centerYAnchor.constraint(equalTo: containerViewForButtons.centerYAnchor),
            stackViewButtonsInContainer.leadingAnchor.constraint(equalTo: containerViewForButtons.leadingAnchor, constant: 16),
            stackViewButtonsInContainer.trailingAnchor.constraint(equalTo: containerViewForButtons.trailingAnchor, constant: -16),
            stackViewButtonsInContainer.heightAnchor.constraint(equalToConstant: 43),
            
            LoginButton.heightAnchor.constraint(equalToConstant: 43),
            SignUpButton.heightAnchor.constraint(equalToConstant: 43)
            
        ])
    }
    
}
