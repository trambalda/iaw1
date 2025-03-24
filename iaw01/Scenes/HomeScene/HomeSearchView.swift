import UIKit

class HomeSearchView: UIView {
    lazy var homeSearchBar: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .light80
        textField.placeholder = "Search Food, Restaurants etc."
        textField.layer.cornerRadius = 14
        textField.clipsToBounds = true
        
        let searchIconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 52))
        let searchIcon = UIImageView(image: .searchIcon)
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.frame = CGRect(x: 12, y: 14, width: 24, height: 24)
        searchIconContainer.addSubview(searchIcon)
        
        textField.leftView = searchIconContainer
        textField.leftViewMode = .always
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(homeSearchBar)
        
        NSLayoutConstraint.activate([
            homeSearchBar.topAnchor.constraint(equalTo: topAnchor),
            homeSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            homeSearchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeSearchBar.heightAnchor.constraint(equalToConstant: 52),
            homeSearchBar.widthAnchor.constraint(equalToConstant: 348),
        ])
    }
}
