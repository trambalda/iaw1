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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutAndConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleView, buttonsView, socialLoginView])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
}
