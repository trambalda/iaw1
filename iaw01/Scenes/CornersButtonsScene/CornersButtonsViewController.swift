import UIKit

final class CornersButtonsViewController: UIViewController {
    
    private lazy var skipButton: CornersButton = {
        let button = CornersButton(style: .skipButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Skip button tapped")
        }
        return button
    }()
    
    private lazy var nextButton: CornersButton = {
        let button = CornersButton(style: .nextButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Next button tapped")
        }
        return button
    }()
    
    private lazy var verifyButton: CornersButton = {
        let button = CornersButton(style: .verifyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Verify button tapped")
        }
        return button
    }()
    
    private lazy var locationButton: CornersButton = {
        let button = CornersButton(style: .locationButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Location button tapped")
        }
        return button
    }()
    
    private lazy var loginButton: CornersButton = {
        let button = CornersButton(style: .loginButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Login button tapped")
        }
        return button
    }()
    
    private lazy var savePinkButton: CornersButton = {
        let button = CornersButton(style: .savePinkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Save pink button tapped")
        }
        return button
    }()
    
    private lazy var saveDarkButton: CornersButton = {
        let button = CornersButton(style: .saveDarkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setOnTap { [weak self] in
            print("Save dark button tapped")
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .light100
        
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(verifyButton)
        view.addSubview(locationButton)
        view.addSubview(loginButton)
        view.addSubview(savePinkButton)
        view.addSubview(saveDarkButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nextButton.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            
            verifyButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 16),
            verifyButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            verifyButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            
            locationButton.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 16),
            locationButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            locationButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            
            savePinkButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            savePinkButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            savePinkButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            
            saveDarkButton.topAnchor.constraint(equalTo: savePinkButton.bottomAnchor, constant: 16),
            saveDarkButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            saveDarkButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor)
        ])
    }
} 