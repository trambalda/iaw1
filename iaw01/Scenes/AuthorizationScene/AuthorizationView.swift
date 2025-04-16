import UIKit

final class AuthorizationView: UIView {
    
    var onLoginTap: ((AuthorizationModel) -> Void)?
    var onSignupTap: ((AuthorizationModel) -> Void)?
    
    public let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    public lazy var bottomButton: CornersButton = {
        let button = CornersButton(style: .loginButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var segmentedControl: AuthorizationSegmentedControl = {
        let control = AuthorizationSegmentedControl()
        control.toggleTextField = { [weak self] selection in
            self?.switchView(to: selection)
        }
        return control
    }()
    
    private let titleView = AuthorizationTitleView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView = UIView()
    
    private var currentSelection: AuthorizationSegmentedControl.Selection = .login
    
    private lazy var loginView: AuthorizationLoginView = {
        let view = AuthorizationLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewChanged = { [weak self] model in
            self?.updateButtonState()
        }
        return view
    }()
    
    private lazy var signupView: AuthorizationSignupView = {
        let view = AuthorizationSignupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewChanged = { [weak self] model in
            self?.updateButtonState()
        }
        return view
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
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        switchView(to: .login)
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleView)
        contentStackView.addArrangedSubview(segmentedControl)
        contentStackView.addArrangedSubview(containerView)
        containerView.addSubview(loginView)
        containerView.addSubview(signupView)
        scrollView.addSubview(bottomButton)
        
        contentStackView.setCustomSpacing(21, after: titleView)
        contentStackView.setCustomSpacing(24, after: segmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loginView.topAnchor.constraint(equalTo: containerView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            signupView.topAnchor.constraint(equalTo: containerView.topAnchor),
            signupView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func updateButtonState() {
        let isFilled: Bool
        
        switch currentSelection {
        case .login:
            let model = loginView.model
            isFilled = !(model.email?.isEmpty ?? true)
            && !(model.password?.isEmpty ?? true)
        case .signUp:
            let model = signupView.model
            isFilled = !(model.name?.isEmpty ?? true)
            && !(model.phone?.isEmpty ?? true)
            && !(model.password?.isEmpty ?? true)
        }
        
        bottomButton.isEnabled = isFilled
        bottomButton.alpha = isFilled ? 1.0 : 0.5
    }
    
    
    @objc private func bottomButtonTapped() {
        
        let model: AuthorizationModel = {
            switch currentSelection {
            case .login:
                return loginView.model
            case .signUp:
                return signupView.model
            }
        }()
        
        if currentSelection == .login {
            onLoginTap?(model)
        } else if currentSelection == .signUp {
            onSignupTap?(model)
        }
    }
    
    private func switchView(to selection: AuthorizationSegmentedControl.Selection) {
        currentSelection = selection
        
        let fromView: UIView
        let toView: UIView
        
        switch selection {
        case .login:
            fromView = signupView
            toView = loginView
        case .signUp:
            fromView = loginView
            toView = signupView
        }
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            fromView.alpha = 0
            toView.alpha = 1
        }
        
       updateButtonState()
    }
}
