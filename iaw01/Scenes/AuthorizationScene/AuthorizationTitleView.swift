//
//  AuthorizationTitleView.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit

class AuthorizationTitleView: UIStackView {
    
    private let titleLabel: UILabel = {
         let label = UILabel()
         label.attributedText = Font.heading4.compose("Welcome", color: .dark100)
         return label
    }()
    
    private let descriptionLabel: UILabel = {
         let label = UILabel()
        label.attributedText = Font.body.compose("Sign up or Login to your Account", color: .dark80)
         return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        axis = .vertical
        spacing = -3
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
    }
}


