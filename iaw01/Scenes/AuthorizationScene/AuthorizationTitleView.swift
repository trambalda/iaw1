//
//  AuthorizationTitleView.swift
//  iaw01
//
//  Created by Дария Акатова on 19.03.2025.
//

import UIKit


class AuthorizationTitleView: UIView {
    
    private static func createLabel(text: String, font: Font.Name, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.setTextAndFont(text, font: font)
        label.textColor = textColor
        return label
    }
    
    private let autorizationHeadLabel: UILabel =
    AuthorizationTitleView.createLabel(text: "Welcome!", font: .heading4, textColor: .dark100)
    
    private let autorizationDescriptionLabel: UILabel =
    AuthorizationTitleView.createLabel(text: "Sign up or Login to your Account", font: .body, textColor: .dark80)
    
    private let stackViewLabels: UIStackView = {
        let stackView = UIStackView()
//        без vertical не получается 
        stackView.axis = .vertical
        stackView.spacing = -3
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayoutTitleView()
        setupConstraintsLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutTitleView() {
        stackViewLabels.addArrangedSubview(autorizationHeadLabel)
        stackViewLabels.addArrangedSubview(autorizationDescriptionLabel)
        addSubview(stackViewLabels)
        
        
    }
    
}

// MARK: - Constraints

extension AuthorizationTitleView {
    private func setupConstraintsLabels() {
        
        stackViewLabels.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackViewLabels.topAnchor.constraint(equalTo: topAnchor, constant: 49),
            stackViewLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21)
        ])
    }
    
}
