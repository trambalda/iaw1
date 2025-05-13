import UIKit

final class AuthorizationView: UIView {
    
    var onLoginTap: ((AuthorizationModel) -> Void)?
    var onSignupTap: ((AuthorizationModel) -> Void)?
    
    public let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    public let bottomButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var model: AuthorizationModel = .empty {
        didSet {
            loginView.model = model
            signupView.model = model
            updateButtonState()
        }
    }
    
    public var bottomButtonBottomConstraint: NSLayoutConstraint!
    
    private let titleView = AuthorizationTitleView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let containerView = UIView()
        
    private var currentSelection: AuthorizationSegmentedControl.Selection = .login
    
    private lazy var segmentedControl: AuthorizationSegmentedControl = {
        let control = AuthorizationSegmentedControl()
        control.toggleTextField = { [weak self] selection in
            self?.switchView(to: selection)
        }
        return control
    }()
    
    private lazy var loginView: AuthorizationLoginView = {
        let view = AuthorizationLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.model = model
        view.viewChanged = { [weak self] model in
            self?.updateButtonState()
        }
        return view
    }()
    
    private lazy var signupView: AuthorizationSignupView = {
        let view = AuthorizationSignupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.model = model
        view.viewChanged = { [weak self] model in
            self?.updateButtonState()
        }
        return view
    }()
    
    private lazy var bottomButton: CornersButton = {
        let button = CornersButton(style: .loginButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        switchView(to: .login)
        updateButtonState()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        addSubview(bottomButtonContainer)
        scrollView.addSubview(contentStackView)
        bottomButtonContainer.addSubview(bottomButton)
        contentStackView.addArrangedSubview(titleView)
        contentStackView.addArrangedSubview(segmentedControl)
        contentStackView.addArrangedSubview(containerView)
        containerView.addSubview(loginView)
        containerView.addSubview(signupView)
        
        contentStackView.setCustomSpacing(21, after: titleView)
        contentStackView.setCustomSpacing(24, after: segmentedControl)
        contentStackView.setCustomSpacing(2000, after: containerView)
    }
    
    private func setupConstraints() {
        bottomButtonBottomConstraint = bottomButtonContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -55)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomButtonContainer.topAnchor),
            
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
            
            bottomButtonContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomButtonBottomConstraint, 
            bottomButton.topAnchor.constraint(equalTo: bottomButtonContainer.topAnchor, constant: 1),
            bottomButton.leadingAnchor.constraint(equalTo: bottomButtonContainer.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: bottomButtonContainer.trailingAnchor, constant: -16),
            bottomButton.bottomAnchor.constraint(equalTo: bottomButtonContainer.bottomAnchor, constant: -16),
        ])
    }
    
    private func updateButtonState() {
        let isFilled: Bool
        
        switch currentSelection {
        case .login:
            isFilled = loginView.model.isLoginModelFilled
        case .signUp:
            isFilled = signupView.model.isSignUpModelFilled
        }
        bottomButton.isEnabled = isFilled
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
