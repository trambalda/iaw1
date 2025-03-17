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
        label.font = Font.body
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var dishImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .arrowRight
        
        return image
    }()
    
    private var restaurantImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
       
        return image
    }()
    
    private let restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = Font.note
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let restaurantStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 9
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var model: DishCellModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.foodTitle
            dishImage.image = model.foodImage ?? UIImage(systemName: "photo")
            restaurantImage.image = model.restImage ?? UIImage(systemName: "photo")
            restaurantLabel.text = model.restTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        restaurantStack.addArrangedSubview(restaurantImage)
        restaurantStack.addArrangedSubview(restaurantLabel)
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(restaurantStack)
        
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
