//
//  VerifyPhoneNumberViewController.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberViewController: UIViewController {
    
    private let verifyPhoneNumberView = VerifyPhoneNumberView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        setupView()
        setupConstraints()
    }
    
}

extension VerifyPhoneNumberViewController {
    private func setupView() {
        verifyPhoneNumberView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verifyPhoneNumberView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verifyPhoneNumberView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            verifyPhoneNumberView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            verifyPhoneNumberView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            verifyPhoneNumberView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
