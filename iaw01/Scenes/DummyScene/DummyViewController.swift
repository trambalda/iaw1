import UIKit

final class DummyViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тестирование кнопок"
        label.font = Font.heading3
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Кнопки для тестирования
    private lazy var blueButton: MainButton = {
        let button = MainButton(
            style: .blue,
            title: "Continue",
            icon: .chevronRight,
            iconPosition: .right
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pinkButton: MainButton = {
        let button = MainButton(
            style: .pink,
            title: "Save and Use",
            icon: .dotScope,
            iconPosition: .left
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var darkButton: MainButton = {
        let button = MainButton(
            style: .dark,
            title: "Save",
            icon: .checkmarkCircle,
            iconPosition: .left
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var lightButton: MainButton = {
        let button = MainButton(
            style: .light,
            title: "Skip",
            icon: .chevronRight,
            iconPosition: .right
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var disabledButton: MainButton = {
        let button = MainButton(
            style: .blue,
            title: "Verify and Continue",
            icon: .checkmarkCircle,
            iconPosition: .right,
            isEnabled: false
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: .light100)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        // Добавляем кнопки в stackView
        stackView.addArrangedSubview(blueButton)
        stackView.addArrangedSubview(pinkButton)
        stackView.addArrangedSubview(darkButton)
        stackView.addArrangedSubview(lightButton)
        stackView.addArrangedSubview(disabledButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32)
        ])
    }
    
    @objc private func buttonTapped(_ sender: MainButton) {
        print("Нажата кнопка: \(sender)")
    }
}
