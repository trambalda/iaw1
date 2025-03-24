import UIKit

class HomeAddressView: UIView {
    var onAddressButtonTap: (() -> Void)?
    
    lazy var adressButton: UIButton = {
        let homeAdressbutton = UIButton()
        homeAdressbutton.backgroundColor = .peach60
        homeAdressbutton.layer.cornerRadius = 12
        homeAdressbutton.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressImage = UIImageView(image: .adressPointMap)
        homeAdressImage.contentMode = .scaleAspectFit
        homeAdressImage.translatesAutoresizingMaskIntoConstraints = false
        
        let homeAdressTitle = UILabel()
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
    
    var homeAdressTitle: UILabel? {
        return adressButton.subviews.first?.subviews.last as? UILabel
    }
    
    func configureAddress(title: String) {
        homeAdressTitle?.attributedText = Font.body.compose(title, color: .peach100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtonTarget()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupButtonTarget()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(adressButton)
        
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: topAnchor),
            adressButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            adressButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            adressButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupButtonTarget() {
        adressButton.addTarget(self, action: #selector(addressButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addressButtonTapped() {
        onAddressButtonTap?()
    }
}
