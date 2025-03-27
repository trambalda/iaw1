//
//  VerifyPhoneNumberViewController.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 13.03.2025.
//

import UIKit

class VerifyPhoneNumberViewController: UIViewController {
    
    private lazy var verifyPhoneNumberView: VerifyPhoneNumberView = {
        let view = VerifyPhoneNumberView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = verifyPhoneNumberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        verifyPhoneNumberView.codeInputView.firstTextFieldBecomeFirstResponder()
    }
}
