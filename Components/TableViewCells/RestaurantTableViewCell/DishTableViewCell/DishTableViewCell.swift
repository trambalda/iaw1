//
//  DishTableViewCell.swift
//  iaw01
//
//  Created by Алина Ражева on 14.03.2025.
//

import UIKit

final class DishTableViewCell: UITableViewCell {
    
    private let cellImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    private let arrowImage: UIImageView = {
        let imageView = UIImageView(image: .arrowRight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let noPhotoImage: UIImage? = {
        let image = UIImage(systemName: "photo")
        return image
    }()
    
    private let restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = Font.note
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dishImage: UIImageView = {
        cellImageView
    }()
     
    private lazy var restaurantImage: UIImageView = {
        cellImageView
    }()
    
    var model: DishCellModel {
        didSet {
            nameLabel.text = model.foodTitle
            dishImage.image = model.foodImage ?? noPhotoImage
            restaurantImage.image = model.restaurantImage ?? noPhotoImage
            restaurantLabel.text = model.restaurantTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.model = DishCellModel(foodImage: nil, foodTitle: "", restaurantImage: nil, restaurantTitle: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     mainStack
        dishImage
        infoStack
            nameLabel
            restaurantStack
                restaurantImage
                restaurantLabel
        arrowImage
     */
    
    private func setupUI() {
        let restaurantStack = UIStackView()
        restaurantStack.spacing = 5
        restaurantStack.alignment = .center
        restaurantStack.addArrangedSubview(restaurantImage)
        restaurantStack.addArrangedSubview(restaurantLabel)
    
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 3
        infoStack.alignment = .leading
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(restaurantStack)
        
        let mainStack = UIStackView()
        mainStack.spacing = 9
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(dishImage)
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(arrowImage)
        
        contentView.addSubview(mainStack)
       
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dishImage.widthAnchor.constraint(equalToConstant: 106),
            dishImage.heightAnchor.constraint(equalToConstant: 49),
            
            restaurantImage.widthAnchor.constraint(equalToConstant: 21),
            restaurantImage.heightAnchor.constraint(equalToConstant: 21),
            
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
