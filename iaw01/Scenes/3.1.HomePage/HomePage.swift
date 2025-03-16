import UIKit

class ViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        $0.backgroundColor = UIColor(named:"light100")
        $0.addSubview(scrollViewContent)
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .never
        return $0
    }(UIScrollView(frame: view.frame))
    
    lazy var scrollViewContent: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.addSubview(adressButton)
        $0.addSubview(helloLabel)
        $0.addSubview(homeSearchBar)
        return $0
    }(UIView())
    
    let adressButton: UIButton = {
        let homeAdressbutton = UIButton()
        homeAdressbutton.backgroundColor = .peach60
        homeAdressbutton.layer.cornerRadius = 12
        homeAdressbutton.layer.masksToBounds = true
        homeAdressbutton.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressImage = UIImageView(image: .adressPointMap)
        homeAdressImage.contentMode = .scaleAspectFit
        homeAdressImage.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressTitle = UILabel()
        homeAdressTitle.setTextAndFont("32, Kingston Ln.", font: .body)
        homeAdressTitle.textColor = .peach100
        
        let homeAdressStack = UIStackView(arrangedSubviews: [homeAdressImage, homeAdressTitle])
        homeAdressStack.spacing = 4
        homeAdressStack.translatesAutoresizingMaskIntoConstraints = false
        
        homeAdressbutton.addSubview(homeAdressStack)
        
        NSLayoutConstraint.activate([
            homeAdressImage.widthAnchor.constraint(equalToConstant: 19),
            homeAdressStack.leadingAnchor.constraint(equalTo: homeAdressbutton.leadingAnchor, constant: 12),
            homeAdressStack.trailingAnchor.constraint(equalTo: homeAdressbutton.trailingAnchor, constant: -12),
            homeAdressStack.centerYAnchor.constraint(equalTo: homeAdressbutton.centerYAnchor),
            homeAdressbutton.heightAnchor.constraint(equalToConstant: 43),
            homeAdressbutton.widthAnchor.constraint(equalToConstant: 165),
        ])
        return homeAdressbutton
    }()

    let helloLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTextAndFont("Good Evening Luisa", font: .heading5)
        return $0
    }(UILabel())
    
    let homeSearchBar: UITextField = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named:"light100")
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            adressButton.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 60),
            adressButton.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 21),
            
            helloLabel.topAnchor.constraint(equalTo: adressButton.bottomAnchor, constant: 21),
            helloLabel.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 21),
            
            homeSearchBar.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 12),
            homeSearchBar.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 21),
            homeSearchBar.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor),
            homeSearchBar.heightAnchor.constraint(equalToConstant: 52),
            homeSearchBar.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -21),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }
    @objc private func handleTap() {
        homeSearchBar.resignFirstResponder()
    }
    }

