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
    private var selectedLeadingConstraint: NSLayoutConstraint!
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var selectionButton: UIView = {
        let view = UIView()
        view.backgroundColor = .pink100
        view.layer.cornerRadius = buttonHeight / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        backgroundColor = .pink60
        layer.cornerRadius = viewHeight / 2
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
        addSubview(selectionButton)
    }
    
    @objc private func loginTapped() {
        toggleTextField?(.login)
        updateSelectionButton(position: .login, animated: true)
    }
    
    @objc private func signUpTapped() {
        toggleTextField?(.signUp)
        updateSelectionButton(position: .signUp, animated: true)
    }
    
    func updateSelectionButton(position: Selection, animated: Bool) {
        let selectedButton = position == .login ? loginButton : signUpButton
        
        selectedLeadingConstraint.constant = selectedButton.frame.origin.x - loginButton.frame.origin.x
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
        else {
            self.layoutIfNeeded()
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: viewHeight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            selectionButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectionButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor)
        ])
        
        selectedLeadingConstraint = selectionButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor)
        selectedLeadingConstraint.isActive = true
    }
}
