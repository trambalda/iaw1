import UIKit

class AuthorizationSegmentedControl: UIView {
    
    enum Selection {
        case login
        case signUp
    }
    
    var toggleTextField: ((Selection) -> Void)?
    
    private let viewHeight: CGFloat = 63
    private let buttonHeight: CGFloat = 43
    private var selectedLeadingConstraint: NSLayoutConstraint!
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .pink100
        view.layer.cornerRadius = buttonHeight / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .pink60
        layer.cornerRadius = viewHeight / 2
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        setupConstraints()
        loginTapped()
    }
    
    private func setupLayout() {
        addSubview(selectionView)
        addSubview(stackView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
    }
    
    @objc private func loginTapped() {
        updateSelectionButton(position: .login)
        toggleTextField?(.login)
    }
    
    @objc private func signUpTapped() {
        updateSelectionButton(position: .signUp)
        toggleTextField?(.signUp)
    }
    
    func updateSelectionButton(position: Selection) {
        let selectedButton: UIButton
        let unselectedButton: UIButton
        
        switch position {
        case .login:
            selectedButton = loginButton
            unselectedButton = signUpButton
        case .signUp:
            selectedButton = signUpButton
            unselectedButton = loginButton
        }
        
        selectedLeadingConstraint.constant = selectedButton.frame.origin.x - loginButton.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            selectedButton.setTitleColor(.light100, for: .normal)
            unselectedButton.setTitleColor(.pink100, for: .normal)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: viewHeight),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            selectionView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectionView.widthAnchor.constraint(equalTo: loginButton.widthAnchor)
        ])
        
        selectedLeadingConstraint = selectionView.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor)
        selectedLeadingConstraint.isActive = true
    }
}
