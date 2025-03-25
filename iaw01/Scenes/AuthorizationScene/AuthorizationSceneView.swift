//
//  AuthorizationSceneView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AuthorizationSceneView: UIView {
    
    private let titleView = AuthorizationTitleView()
    private let segmentedControl = AuthorizationSegmentedControl()
    private let socialLoginView = AuthorizationSocialNetworkButtonsView()
    private let emailTextFieldView = StringTextField(with: .emailStyle)
    private let nameTextFieldView =  StringTextField(with: .nameStyle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private  func configure() {
        setupButtonAction()
        setupLayoutAndConstraints()
        setupButtonAction()
    }
    
    private func setupButtonAction() {
        segmentedControl.toggleTextField = { [weak self] selection in
            switch selection {
            case .login:
                self?.emailTextFieldView.isHidden = false
                self?.nameTextFieldView.isHidden = true
            case .signUp:
                self?.emailTextFieldView.isHidden = true
                self?.nameTextFieldView.isHidden = false
            }
        }
    }
    
    private func setupLayoutAndConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            titleView,
            segmentedControl,
            emailTextFieldView,
            nameTextFieldView,
            socialLoginView])
        
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21)
        ])
    }
    
}
