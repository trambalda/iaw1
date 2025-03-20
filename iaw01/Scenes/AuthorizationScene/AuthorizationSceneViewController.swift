//
//  AutorizathionSceneViewController.swift
//  iaw01
//
//  Created by Дария Акатова on 14.03.2025.
//

import UIKit

class AuthorizationSceneViewController: UIViewController {
    
    private lazy var authorizationSceneView: AuthorizationSceneView = {
        let view = AuthorizationSceneView(frame: UIScreen.main.bounds)
        return view
    }()
    
    override func loadView() {
        view = authorizationSceneView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
