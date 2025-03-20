//
//  AuthorizationSocialNetworkLoginView.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationSocialNetworkLoginView: UIView {
    
    private let loginUsingLable: UILabel = {
        let label = UILabel()
        label.setTextAndFont("Or Login Using:", font: .body)
        label.textColor = .dark80
        return label
    }()
    
    private lazy var lineViewNearWithLoginUsing: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .light60
        return lineView
    }()
    
    private lazy var lineContainerView: UIView = {
        let view = UIView()
        view.addSubview(lineViewNearWithLoginUsing)
        return view
    }()
    
    private let loginUsingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private static func createSocialNetworkButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35.5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.light60.cgColor
        button.clipsToBounds = true
        
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        
        return button
    }
    
    private let googleButton = createSocialNetworkButton(imageName: "googleLogo")
    private let appleButton = createSocialNetworkButton(imageName: "appleLogo")
    
    private lazy var stackViewSocialNetworkButton: UIStackView = {
        let stackViewInContainer = UIStackView()
        stackViewInContainer.axis = .horizontal
        stackViewInContainer.spacing = 20
        stackViewInContainer.distribution = .fillEqually
        stackViewInContainer.alignment = .leading
        return stackViewInContainer
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutLoginUsingView()
        setupConstraintsLoginUsing()
        setupLayoutSocialLoginView()
        setupConstraintSocialNetworkButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutLoginUsingView() {
        addSubview(loginUsingStackView)
        loginUsingStackView.addArrangedSubview(loginUsingLable)
        loginUsingStackView.addArrangedSubview(lineContainerView)
    }
    
    private func setupLayoutSocialLoginView() {
        addSubview(stackViewSocialNetworkButton)
        stackViewSocialNetworkButton.addArrangedSubview(googleButton)
        stackViewSocialNetworkButton.addArrangedSubview(appleButton)
    }
}

// MARK: - Constraints

extension AuthorizationSocialNetworkLoginView {
    
    private func setupConstraintsLoginUsing() {
  
          loginUsingStackView.translatesAutoresizingMaskIntoConstraints = false
          lineViewNearWithLoginUsing.translatesAutoresizingMaskIntoConstraints = false
  
          NSLayoutConstraint.activate([
              loginUsingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//  нужно установить  loginUsingStackView.topAnchor.constraint(equalTo: forgotPasswordLable.bottomAnchor, constant: 38), не знаю, как правильно реализовать
              loginUsingStackView.topAnchor.constraint(equalTo: topAnchor, constant: 486),
              loginUsingStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
              loginUsingStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
  
              lineViewNearWithLoginUsing.centerYAnchor.constraint(equalTo: lineContainerView.centerYAnchor),
              lineViewNearWithLoginUsing.leadingAnchor.constraint(equalTo: lineContainerView.leadingAnchor),
              lineViewNearWithLoginUsing.trailingAnchor.constraint(equalTo: lineContainerView.trailingAnchor),
              lineViewNearWithLoginUsing.heightAnchor.constraint(equalToConstant: 1)

          ])
      }
    
    private func setupConstraintSocialNetworkButton() {
        
        stackViewSocialNetworkButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            stackViewSocialNetworkButton.topAnchor.constraint(equalTo: loginUsingStackView.bottomAnchor, constant: 28),
            stackViewSocialNetworkButton.topAnchor.constraint(equalTo: topAnchor, constant: 537),
            stackViewSocialNetworkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            
            googleButton.widthAnchor.constraint(equalToConstant: 71),
            googleButton.heightAnchor.constraint(equalToConstant: 71),
            
            appleButton.widthAnchor.constraint(equalToConstant: 71),
            appleButton.heightAnchor.constraint(equalToConstant: 71)
            
        ])
    }
    
}
