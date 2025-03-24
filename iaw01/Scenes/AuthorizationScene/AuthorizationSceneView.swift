//
//  AuthorizationSceneView.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AuthorizationSceneView: UIView {
    
    private let titleView = AuthorizationTitleView()
    private let buttonsView = AuthorizationSegmentedControl()
    private let socialLoginView = AuthorizationSocialNetworkButtonsView()
    
    private let emailTextFieldView:  StringTextField = {
        let textField = StringTextField(with: .emailStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameTextFieldView: StringTextField = {
        let textField = StringTextField(with: .nameStyle)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonsView.toggleTextField = { [weak self] isLoginSelected in
            self?.emailTextFieldView.isHidden = !isLoginSelected
            self?.nameTextFieldView.isHidden = isLoginSelected
            
            if isLoginSelected {
                self?.buttonsView.updateButtonColors(isLogin: true)
            } else {
                self?.buttonsView.updateButtonColors(isLogin: false)
            }
        }
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutAndConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleView,
                                                       buttonsView,
                                                       emailTextFieldView,
                                                       nameTextFieldView,
                                                       socialLoginView])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            emailTextFieldView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 180),
            emailTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextFieldView.heightAnchor.constraint(equalToConstant: 80),
            
            nameTextFieldView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 180),
            nameTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
