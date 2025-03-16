//
//  ChangeLocationViewController.swift
//  iaw01
//
//  Created by VadimK on 14.03.25.
//
import UIKit

class ChangeLocationViewController: UIViewController {
   
    
    
   private let searchbar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.placeholder = "Look for an Address..."
       //Visualice frame arround touchbar
        searchbar.layer.borderColor = UIColor.red.cgColor
        return searchbar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white                
        return tableView
    }()
    
    private let useCurrentLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Use Current Location", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ChangeLocationViewController loaded")
        view.backgroundColor = .yellow
        
        // Add searchbar on screen
        view.addSubview(searchbar)
        view.addSubview(tableView)
        view.addSubview(useCurrentLocationButton)
        
        // Dissable auto sizing
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        useCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Set auto Layout
        NSLayoutConstraint.activate([
            searchbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchbar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            useCurrentLocationButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            useCurrentLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            useCurrentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            useCurrentLocationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
}
