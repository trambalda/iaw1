//
//  AuthorizationView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AuthorizationView: UIView {
    private let titleView = AuthorizationTitleView()
    
    private lazy var segmentedControl: AuthorizationSegmentedControl = {
        let control = AuthorizationSegmentedControl()
        control.toggleTextField = { [weak self] selection in
            self?.switchView(to: selection)
        }
        return control
    }()
    
    private let loginView: AuthorizationLoginView = {
        let view = AuthorizationLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signupView: AuthorizationSignupView = {
        let view = AuthorizationSignupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView = UIView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        switchView(to: .login)
    }
    
    private func switchView(to selection: AuthorizationSegmentedControl.Selection) {
        let fromView: UIView
        let toView: UIView
        switch selection {
        case .login:
            fromView = signupView
            toView = loginView
        case .signUp:
            fromView = loginView
            toView = signupView
        }
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            fromView.alpha = 0
            toView.alpha = 1
        }
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(loginView)
        containerView.addSubview(signupView)
        
        stackView.setCustomSpacing(21, after: titleView)
        stackView.setCustomSpacing(24, after: segmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            loginView.topAnchor.constraint(equalTo: containerView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            signupView.topAnchor.constraint(equalTo: containerView.topAnchor),
            signupView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signupView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
