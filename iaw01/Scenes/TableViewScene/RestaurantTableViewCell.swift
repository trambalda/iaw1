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
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.font = Font.note
        label.textColor = .dark60
        label.numberOfLines = 1
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
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .arrowRight

        return image
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var model: RestaurantCellModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.restTitle
            addressLabel.text = model.restAddress
            cellImage.image = model.restImage ?? UIImage(systemName: "photo")
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
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(addressLabel)
        
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
