//
//  ChangeLocationViewController.swift
//  iaw01
//
//  Created by VadimK on 14.03.25.
//
import UIKit

//add model

struct LocationSection {
    let title: String
    let locations: [String]
    
    
}
class ChangeLocationViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Look for an Address"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var locationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChangeLocationCell.self, forCellReuseIdentifier: ChangeLocationCell.reuseIdentifier)
        // Set delegates
        locationTableView.delegate = self
        locationTableView.dataSource = self
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
    
    //Sample location data for UI section
    private let locationSections: [LocationSection] = [
        LocationSection(title: "Saved Locations", locations: [
            "🏠 34, George Avenue, Brampton, ON L6T 8H6",
            "🏢 31244, King Street, Toronto, ON"
        ]),
        LocationSection(title: "Recents", locations: [
            "📍 56, George Avenue, Brampton, ON"
    ])
    ]
    /*private let savedLocations: [String] = [
        "🏠 34, George Avenue, Brampton, ON L6T 8H6",
        "🏢 31244, King Street, Toronto, ON"
    ]
    
    private let recentLocations: [String] = [
        "📍 56, George Avenue, Brampton, ON"
    ]
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
      
        
        // Hinzufügen der UI-Elemente
        view.addSubview(searchBar)
        view.addSubview(locationTableView)
        view.addSubview(useCurrentLocationButton)
        
        
        
        setupConstraints()
        
        // Refresh the table if it does not load
        locationTableView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
         
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
           
            locationTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            locationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationTableView.bottomAnchor.constraint(equalTo: useCurrentLocationButton.topAnchor, constant: -20),
            
          
            useCurrentLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            useCurrentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            useCurrentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            useCurrentLocationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}








extension ChangeLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return locationSections[section].title
    }
}


extension ChangeLocationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return locationSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationSections[section].locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeLocationCell.reuseIdentifier, for: indexPath) as! ChangeLocationCell
        let location = locationSections[indexPath.section].locations[indexPath.row]
        cell.textLabel?.text = location
        return cell
    }
}


