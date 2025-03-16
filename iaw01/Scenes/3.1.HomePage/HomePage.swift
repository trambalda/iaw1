import UIKit

class ViewController: UIViewController {

    //MARK: - Views
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let helloLabel = UILabel()
    private let adressButton: UIButton = {
        let iconSize = CGSize(width: 19, height: 19)
        let adressPointIcon = UIImage(named: "adressPointMap")!
        UIGraphicsBeginImageContextWithOptions(iconSize, false, 0.0)
        adressPointIcon.draw(in: CGRect(origin: .zero, size: iconSize))
        let resizedIcon = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        var configuration = UIButton.Configuration.plain()
        configuration.title = "32, Kingston Ln."
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = UIColor(named: "peach100")
        configuration.image = resizedIcon.withTintColor(UIColor(named: "peach100")!, renderingMode: .alwaysOriginal)
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)

        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.backgroundColor = UIColor(named:"peach60")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    private let homeSearchTextField: UITextField = {
        let textField = UITextField()
                textField.placeholder = "Search Food, Restaurants etc."
                textField.font = UIFont(name: "TWKEverett-Regular", size: 17)
                textField.layer.cornerRadius = 14
                textField.layer.masksToBounds = true
                textField.backgroundColor = UIColor(named: "light80")
                textField.textColor = UIColor(named: "blue80")
                textField.clearButtonMode = .whileEditing
                textField.returnKeyType = .search
        
        if let searchIcon = UIImage(named: "searchIcon") {
            let resizedSearchIcon = CGSize(width: 24, height: 24)
            UIGraphicsBeginImageContextWithOptions(resizedSearchIcon, false, 0.0)
            searchIcon.draw(in: CGRect(origin: .zero, size: resizedSearchIcon))
            let newSearchIcon = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            let searchIconContainer = UIView()
            searchIconContainer.frame = CGRect(x: 0, y: 0, width: 46, height: 24)

            let iconImageView = UIImageView(image: newSearchIcon)
            iconImageView.contentMode = .center
            iconImageView.frame = CGRect(x: 13, y: 0, width: 24, height: 24)
            searchIconContainer.addSubview(iconImageView)

            textField.leftView = searchIconContainer
            textField.leftViewMode = .always
        }
                return textField
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named:"light100")
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }

        @objc private func handleTap() {
            homeSearchTextField.resignFirstResponder()
        }
    }


//MARK: - Setup Layout
private extension ViewController {
    func setupLayout() {
        configureScrollView()
        configureContentView()
        prepairContentView()
        configureAdressButton()
        configureLabel()
        configurateHomeSearchTextField()
        addContentToScrollView()
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func prepairContentView() {
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func configureLabel() {
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.text = "Good Evening Luisa"
        helloLabel.font = UIFont(name: "TWKEverett-Regular", size: 36)
    }
    
    func configureAdressButton() {
        adressButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addContentToScrollView() {
        contentView.addSubview(adressButton)
        contentView.addSubview(helloLabel)
        contentView.addSubview(homeSearchTextField)
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            adressButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            adressButton.widthAnchor.constraint(equalToConstant: 185),
            adressButton.heightAnchor.constraint(equalToConstant: 43),
            
            helloLabel.topAnchor.constraint(equalTo: adressButton.bottomAnchor, constant: 21),
            helloLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            homeSearchTextField.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 12),
            homeSearchTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            homeSearchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            homeSearchTextField.heightAnchor.constraint(equalToConstant: 52),
            homeSearchTextField.widthAnchor.constraint(equalToConstant: 348),
            homeSearchTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    func configurateHomeSearchTextField() {
        homeSearchTextField.translatesAutoresizingMaskIntoConstraints = false
    }
}
