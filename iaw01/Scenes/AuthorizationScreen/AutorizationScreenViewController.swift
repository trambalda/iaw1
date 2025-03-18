//
//  AutorizationScreenViewController.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AutorizationScreenViewController: UIViewController {
    
    private lazy var autorizationScreenView: AutorizationScreenView = {
        let view = AutorizationScreenView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = AutorizationScreenView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
