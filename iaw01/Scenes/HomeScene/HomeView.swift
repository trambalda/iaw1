import UIKit

class HomeView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .light100
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    var addressTitle: String? {
        didSet {
            homeAddressView.configureAddress(title: addressTitle ?? "")
        }
    }

    var onAddressButtonTap: (() -> Void)? {
        didSet {
            homeAddressView.onAddressButtonTap = onAddressButtonTap
        }
    }

    func dismissKeyboard() {
        homeSearchView.homeSearchBar.resignFirstResponder()
    }
    
    lazy var homeAddressView = HomeAddressView()
    lazy var homeSearchView = HomeSearchView()
    
    private var attributedTitle: NSAttributedString?
        
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var title: NSAttributedString? {
        get { return attributedTitle }
        set {
            attributedTitle = newValue
            helloLabel.attributedText = attributedTitle
        }
    }
    
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
    }
}

// MARK: - Layout
extension HomeView {
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(homeAddressView)
        stackView.addArrangedSubview(helloLabel)
        stackView.addArrangedSubview(homeSearchView)

        stackView.setCustomSpacing(12, after: helloLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 21),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -21),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -42),
        ])
    }
}
