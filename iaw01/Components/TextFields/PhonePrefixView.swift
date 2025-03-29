import UIKit

final class PhonePrefixView: UIView {
    
    var prefixDidChange: ((PhoneCountry) -> Void)?
    
    private weak var parentView: UIView?
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        return stack
    }()
    
    private let phonePrefixLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("+1", color: .dark60)
        return label
    }()
    
    private lazy var showPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.downChevron, for: .normal)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineContainerView = UIView()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light60
        return view
    }()
    
    private lazy var countryPickerView: CountryPickerView = {
        let view = CountryPickerView()
        view.isHidden = true
        view.onCountrySelected = { [weak self] country in
            self?.phonePrefixLabel.attributedText = Font.body.compose(country.phoneCode, color: .dark100)
            self?.prefixDidChange?(country)
        }
        return view
    }()
    
    init(parent: UIView?) {
        self.parentView = parent
        super.init(frame: .zero)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(phonePrefixLabel)
        containerStackView.addArrangedSubview(showPickerButton)
        containerStackView.addArrangedSubview(lineContainerView)
        lineContainerView.addSubview(lineView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineContainerView.widthAnchor.constraint(equalToConstant: 20),
            
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineContainerView.centerXAnchor, constant: -2),
            lineView.topAnchor.constraint(equalTo: lineContainerView.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: lineContainerView.bottomAnchor),
        ])
    }
    
    @objc private func showPicker() {
        guard let parentView = parentView else { return }
        
        parentView.addSubview(countryPickerView)
        countryPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryPickerView.topAnchor.constraint(equalTo: parentView.centerYAnchor),
            countryPickerView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            countryPickerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            countryPickerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
        ])
        
        countryPickerView.isHidden = false
    }
}


