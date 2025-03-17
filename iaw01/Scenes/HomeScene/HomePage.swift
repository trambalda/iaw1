import UIKit

class HomeViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named:"light100")
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(scrollViewContent)
        return scrollView
    }()
    
    lazy var scrollViewContent: UIView = {
        let scrollViewContent = UIView()
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContent.backgroundColor = .clear
        scrollViewContent.addSubview(adressButton)
        scrollViewContent.addSubview(helloLabel)
        scrollViewContent.addSubview(homeSearchBar)
        return scrollViewContent
    }()
    
    let adressButton: UIButton = {
        let homeAdressbutton = UIButton()
        homeAdressbutton.backgroundColor = .peach60
        homeAdressbutton.layer.cornerRadius = 12
        homeAdressbutton.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressImage = UIImageView(image: .adressPointMap)
        homeAdressImage.contentMode = .scaleAspectFit
        homeAdressImage.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressTitle = UILabel()
        homeAdressTitle.setTextAndFont("32, Kingston Ln.", font: .body)
        homeAdressTitle.textColor = .peach100
        homeAdressTitle.translatesAutoresizingMaskIntoConstraints = false
        
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

    var helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTextAndFont("Good Evening Luisa", font: .heading5)
        label.textColor = .dark100
        return label
    }()
    
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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

