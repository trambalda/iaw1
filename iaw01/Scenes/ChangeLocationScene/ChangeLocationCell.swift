//
//  ChangeLocationCell.swift
//  iaw01
//
//  Created by VadimK on 30.03.25.
//

import UIKit

final class ChangeLocationCell: UITableViewCell {
    
    static let reuseIdentifier = "ChangeLocationCell"
    
    //Place for UI-elements
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
                textLabel?.numberOfLines = 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
