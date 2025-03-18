import UIKit

class HomeView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .light100
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(stackView)
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [adressButton, helloLabel, homeSearchBar])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        stack.setCustomSpacing(12, after: helloLabel)
        return stack
    }()
    
    lazy var adressButton: UIButton = {
        let homeAdressbutton = UIButton()
        homeAdressbutton.backgroundColor = .peach60
        homeAdressbutton.layer.cornerRadius = 12
        homeAdressbutton.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressImage = UIImageView(image: .adressPointMap)
        homeAdressImage.contentMode = .scaleAspectFit
        homeAdressImage.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressTitle = UILabel()
        homeAdressTitle.attributedText = Font.body.compose("32, Kingston Ln.", color: .peach100)
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

    lazy var helloLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = UIColor(named: "light100")
        setupViews()
        setupConstraints()
    }
    func updateGreeting(timeOfDay: String, name: String) {
            helloLabel.attributedText = Font.heading5.compose("Good \(timeOfDay) \(name)", color: .dark100)
        }
}

// MARK: - Layout
extension HomeView {
    
    private func setupViews() {
        addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -42),

            homeSearchBar.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            homeSearchBar.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}
