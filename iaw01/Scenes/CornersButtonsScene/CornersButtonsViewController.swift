import UIKit

final class CornersButtonsViewController: UIViewController {
    
    private lazy var buttonsEnabledSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.isOn = true
        toggle.addTarget(self, action: #selector(buttonsEnabledChanged), for: .valueChanged)
        return toggle
    }()
    
    private lazy var buttonsEnabledLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Кнопки активны"
        label.textColor = .black
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var skipButton: CornersButton = {
        let button = CornersButton(style: .skipButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Skip button tapped")
        }
        return button
    }()
    
    private lazy var nextButton: CornersButton = {
        let button = CornersButton(style: .nextButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Next button tapped")
        }
        return button
    }()
    
    private lazy var verifyButton: CornersButton = {
        let button = CornersButton(style: .verifyButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Verify button tapped")
        }
        return button
    }()
    
    private lazy var locationButton: CornersButton = {
        let button = CornersButton(style: .locationButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Location button tapped")
        }
        return button
    }()
    
    private lazy var loginButton: CornersButton = {
        let button = CornersButton(style: .loginButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Login button tapped")
        }
        return button
    }()
    
    private lazy var savePinkButton: CornersButton = {
        let button = CornersButton(style: .savePinkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            print("Save pink button tapped")
        }
        return button
    }()
    
    private lazy var saveDarkButton: CornersButton = {
        let button = CornersButton(style: .saveDarkButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
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
        view.addSubview(buttonsEnabledLabel)
        view.addSubview(buttonsEnabledSwitch)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(skipButton)
        buttonsStackView.addArrangedSubview(nextButton)
        view.addSubview(verifyButton)
        view.addSubview(locationButton)
        view.addSubview(loginButton)
        view.addSubview(savePinkButton)
        view.addSubview(saveDarkButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsEnabledLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonsEnabledLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            buttonsEnabledSwitch.centerYAnchor.constraint(equalTo: buttonsEnabledLabel.centerYAnchor),
            buttonsEnabledSwitch.leadingAnchor.constraint(equalTo: buttonsEnabledLabel.trailingAnchor, constant: 8),
            
            buttonsStackView.topAnchor.constraint(equalTo: buttonsEnabledLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            skipButton.widthAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.8),
            
            verifyButton.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 16),
            verifyButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            verifyButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            
            locationButton.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 16),
            locationButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            locationButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            
            savePinkButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            savePinkButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            savePinkButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            
            saveDarkButton.topAnchor.constraint(equalTo: savePinkButton.bottomAnchor, constant: 16),
            saveDarkButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            saveDarkButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor)
        ])
    }
    
    @objc private func buttonsEnabledChanged() {
        let isEnabled = buttonsEnabledSwitch.isOn
        skipButton.isEnabled = isEnabled
        nextButton.isEnabled = isEnabled
        verifyButton.isEnabled = isEnabled
        locationButton.isEnabled = isEnabled
        loginButton.isEnabled = isEnabled
        savePinkButton.isEnabled = isEnabled
        saveDarkButton.isEnabled = isEnabled
    }
} 

