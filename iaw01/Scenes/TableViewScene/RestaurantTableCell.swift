//
//  RestaurantTableCell.swift
//  iaw01
//
//  Created by Алина Ражева on 13.03.2025.
//

import UIKit

final class RestaurantTableCell: UITableViewCell {
    
    //MARK: - UI Elements
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "McDonald's"
        label.font = Font.body
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "18915 Queens Road, Brampton, ON"
        label.font = Font.address
        label.textColor = UIColor(named: "dark60")
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mcdonalds")
        return imageView
    }()
    
    private var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrowRight")
        return imageView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(buttonImageView)
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 36),
            cellImageView.heightAnchor.constraint(equalToConstant: 36),
            
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: buttonImageView.leadingAnchor, constant: 10),
            
            addressLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            addressLabel.trailingAnchor.constraint(equalTo: buttonImageView.leadingAnchor, constant: -10),
            
            buttonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 21),
            buttonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonImageView.widthAnchor.constraint(equalToConstant: 24),
            buttonImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    /*
    // MARK: - Настройка данных
    func configure(with image: UIImage?, name: String, address: String) {
        cellImageView.image = image
        nameLabel.text = name
        addressLabel.text = address
    }
     */
}
