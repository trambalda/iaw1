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
    
    private let loginView = AuthorizationLoginView()
    private let signupView = AuthorizationSignupView()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21)
        ])
    }
}
