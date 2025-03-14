//
//  DishTableViewCell.swift
//  iaw01
//
//  Created by Алина Ражева on 14.03.2025.
//

import UIKit

final class DishTableViewCell: UITableViewCell {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "BBQ Chicken Burger"
        label.font = Font.body
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var dishImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "burger")
        
        return image
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private let restaurantContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var restaurantImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "kfc")
        
        return image
    }()
    
    private let restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "KFC"
        label.font = Font.note
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(dishImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(restaurantContainer)
        contentView.addSubview(arrowImage)
        
        restaurantContainer.addArrangedSubview(restaurantImage)
        restaurantContainer.addArrangedSubview(restaurantLabel)
        
        NSLayoutConstraint.activate([
            dishImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            dishImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dishImage.widthAnchor.constraint(equalToConstant: 106),
            dishImage.heightAnchor.constraint(equalToConstant: 49),
            
            nameLabel.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 9),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -9),
            
            restaurantContainer.leadingAnchor.constraint(equalTo: dishImage.trailingAnchor, constant: 9),
            restaurantContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            restaurantContainer.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -9),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 21),
            restaurantImage.heightAnchor.constraint(equalToConstant: 21),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with foodImage: UIImage?, title: String, restImage: UIImage?, restaurant: String) {
        dishImage.image = foodImage
        nameLabel.text = title
        restaurantImage.image = restImage
        restaurantLabel.text = restaurant
    }
}
