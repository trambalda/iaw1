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
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
