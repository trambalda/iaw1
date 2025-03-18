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
        label.font = Font.body
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.font = Font.note
        label.textColor = .dark60
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var arrowImage: UIImageView = {
        let imageView = UIImageView(image: .arrowRight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var model: RestaurantCellModel {
        didSet {
            nameLabel.text = model.title
            addressLabel.text = model.address
            cellImage.image = model.image ?? UIImage(systemName: "photo")
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.model = RestaurantCellModel(image: nil, title: "", address: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
     /*
      mainStack
         cellImage
         infoStack
             nameLabel
             addressLabel
         arrowImage
      */
     
    private func setupUI() {
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 1
        infoStack.alignment = .leading
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(addressLabel)
        
        let mainStack = UIStackView()
        mainStack.spacing = 10
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(cellImage)
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(arrowImage)
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            mainStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            cellImage.widthAnchor.constraint(equalToConstant: 36),
            cellImage.heightAnchor.constraint(equalToConstant: 36),
     
            arrowImage.widthAnchor.constraint(equalToConstant: 24),
            arrowImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
