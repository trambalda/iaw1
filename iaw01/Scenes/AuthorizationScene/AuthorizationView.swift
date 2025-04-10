import UIKit

class AuthorizationView: UIView {
    
    public var onLoginTap: ((AuthorizationModel) -> Void)?
    public var onSignupTap: ((AuthorizationModel) -> Void)?
    
    public let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    public let bottomButton: CornersButton = {
        let button = CornersButton(style: .loginButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let loginView: AuthorizationLoginView = {
        let view = AuthorizationLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let signupView: AuthorizationSignupView = {
        let view = AuthorizationSignupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var currentSelection: AuthorizationSegmentedControl.Selection = .login
    
    private let titleView = AuthorizationTitleView()
    
    private lazy var segmentedControl: AuthorizationSegmentedControl = {
        let control = AuthorizationSegmentedControl()
        control.toggleTextField = { [weak self] selection in
            self?.switchView(to: selection)
        }
        return control
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView = UIView()
    
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
        setupBottomButtonAction()
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
    
    private func switchView(to selection: AuthorizationSegmentedControl.Selection) {
        let fromView: UIView
        let toView: UIView
        
        switch selection {
        case .login:
            fromView = signupView
            toView = loginView
            bottomButton.setTitle("Login")
        case .signUp:
            fromView = loginView
            toView = signupView
            bottomButton.setTitle("Next")
            
            signupView.onFieldsChange = { [weak self] allFilled in
                guard let self = self else { return }
                
                if allFilled {
                    self.bottomButton.setTitle("Login")
                } else {
                    self.bottomButton.setTitle("Next")
                }
            }
        }
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            fromView.alpha = 0
            toView.alpha = 1
        }
    }
    
    private func setupBottomButtonAction() {
        bottomButton.onTap = { [weak self] in
            guard let self = self else { return }
            
            switch self.currentSelection {
            case .login:
                let model = self.loginView.getModel()
                self.onLoginTap?(model)
            case .signUp:
                let model = self.signupView.getModel()
                self.onLoginTap?(model)
            }
        }
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
}
