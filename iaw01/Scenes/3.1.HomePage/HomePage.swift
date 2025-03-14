import UIKit

class ViewController: UIViewController {

    //MARK: - Views
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let helloLabel = UILabel()
    private let adressButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "TWKEverett-Regular", size: 17)
        button.setTitle("32, Kingston Ln.", for: .normal)
        button.setTitleColor(UIColor(named: "peach100"), for: .normal)
        button.backgroundColor = .peach60
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        if let adressPointIcon = UIImage(named: "adressPointMap") {
            let resizedAdressPointIcon = CGSize (width: 19, height: 19)
            UIGraphicsBeginImageContextWithOptions(resizedAdressPointIcon, false, 0.0)
            adressPointIcon.draw(in: CGRect(origin: .zero, size: resizedAdressPointIcon))
            let newAdressPointIcon = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            button.setImage(newAdressPointIcon, for: .normal)
            button.tintColor = UIColor(named: "peach100")
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        }
        
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = UIColor(named:"light100")
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
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            adressButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            adressButton.widthAnchor.constraint(equalToConstant: 185),
            adressButton.heightAnchor.constraint(equalToConstant: 43)
        ])
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: adressButton.bottomAnchor, constant: 21),
            helloLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            helloLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
