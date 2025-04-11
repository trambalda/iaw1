//
//  expandedViewButton.swift
//  iaw01
//
//  Created by Dinar Mukhlisov on 11.04.2025.
//

import UIKit

class ExpandedButton: UIButton {
    
    var onTap: (() -> ())?
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.7 : 1.0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureExpandButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureExpandButton() {
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        setImage(UIImage(named: "addButton"), for: .normal)
    }
    
    @objc private func buttonAction() {
        onTap?()
    }
}
