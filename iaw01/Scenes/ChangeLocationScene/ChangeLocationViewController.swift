//
//  ChangeLocationViewController.swift
//  iaw01
//
//  Created by VadimK on 14.03.25.
//
import UIKit

class ChangeLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Look for an Address"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    // Wichtige Registrierung der Zelle
        return tableView
    }()
    
    private let useCurrentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📍 Use Current Location", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let savedLocations: [String] = [
        "🏠 34, George Avenue, Brampton, ON L6T 8H6",
        "🏢 31244, King Street, Toronto, ON"
    ]
    
    private let recentLocations: [String] = [
        "📍 56, George Avenue, Brampton, ON"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setzen der Delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Hinzufügen der UI-Elemente
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(useCurrentLocationButton)
        
        setupConstraints()
        
        // Aktualisiere die Tabelle, falls sie nicht lädt
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Searchbar oben
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Tabelle darunter
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: useCurrentLocationButton.topAnchor, constant: -20),
            
            // Button am unteren Rand, aber nicht am Bildschirmrand
            useCurrentLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            useCurrentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            useCurrentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            useCurrentLocationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Saved Locations" : "Recents"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? savedLocations.count : recentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let location: String
        
        if indexPath.section == 0 {
            location = savedLocations[indexPath.row]
        } else {
            location = recentLocations[indexPath.row]
        }
        
        cell.textLabel?.text = location
        return cell
    }
}
