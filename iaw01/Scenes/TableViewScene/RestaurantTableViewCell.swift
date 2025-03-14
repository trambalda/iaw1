//
//  RestaurantTableCell.swift
//  iaw01
//
//  Created by Алина Ражева on 13.03.2025.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {
    
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
        label.font = Font.note
        label.textColor = UIColor(named: "dark60")
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mcdonalds")
        return imageView
    }()
    
    private var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrowRight")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(cellImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(buttonImage)
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            cellImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 36),
            cellImage.heightAnchor.constraint(equalToConstant: 36),
            
            nameLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: buttonImage.leadingAnchor, constant: -10),
            
            addressLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            addressLabel.trailingAnchor.constraint(equalTo: buttonImage.leadingAnchor, constant: -10),
            
            buttonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 21),
            buttonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonImage.widthAnchor.constraint(equalToConstant: 24),
            buttonImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with image: UIImage?, title: String, address: String) {
        cellImage.image = image
        nameLabel.text = title
        addressLabel.text = address
    }
}
