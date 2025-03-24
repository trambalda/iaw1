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
    
    lazy var homeAddressView = HomeAddressView()
    lazy var homeSearchView = HomeSearchView()
    
    var welcomeTitle: String = ""
        
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.attributedText = createAttributedTitle()
        return label
    }()
        
    private func createAttributedTitle() -> NSAttributedString? {
        return welcomeTitle.isEmpty
            ? nil
            : Font.heading5.compose(welcomeTitle, color: .dark100)
    }
        
    func configure(with title: String) {
        welcomeTitle = title
        helloLabel.attributedText = createAttributedTitle()
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
        backgroundColor = UIColor(named: "light100")
        setupViews()
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
        stackView.addArrangedSubview(homeAddressView)
        stackView.addArrangedSubview(helloLabel)
        stackView.addArrangedSubview(homeSearchView)

        stackView.setCustomSpacing(12, after: helloLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
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
