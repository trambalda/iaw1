//
//  AuthorizationTitleView.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit


class AuthorizationTitleView: UIView {
    
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
    
    private let stackViewLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -3
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        stackViewLabels.addArrangedSubview(titleLabel)
        stackViewLabels.addArrangedSubview(descriptionLabel)
        addSubview(stackViewLabels)
        
        stackViewLabels.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension AuthorizationTitleView {
    private func setupConstraints() {
    
        NSLayoutConstraint.activate([
            stackViewLabels.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            stackViewLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
    }
    
}
