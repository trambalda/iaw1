import UIKit

final class OnboardingPageView: UIView {
    
    // MARK: - Приватные хранимые свойства
    private var pagesCount: Int = 0
    
    private let illustrationContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Вычисляемые свойства
    private var verticalStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    // MARK: - Lazy свойства
    private lazy var contentStackView = verticalStackView
    
    // MARK: - Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Приватные методы
    private func setupLayout() {
        addSubview(contentStackView)
        
        illustrationContainer.addSubview(imageView)
        
        contentStackView.addArrangedSubview(illustrationContainer)
        contentStackView.addArrangedSubview(pageControl)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        let illustrationHeightConstraint = Screen.isIPhoneSE
            ? illustrationContainer.heightAnchor.constraint(equalToConstant: 250)
            : illustrationContainer.heightAnchor.constraint(equalTo: illustrationContainer.widthAnchor)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            
            illustrationHeightConstraint,
            
            imageView.topAnchor.constraint(equalTo: illustrationContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: illustrationContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: illustrationContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: illustrationContainer.bottomAnchor)
        ])
    }
    
    // MARK: - Публичные методы
    func configure(with pages: [OnboardingPage]) {
        self.pagesCount = pages.count
        pageControl.numberOfPages = pagesCount
    }
    
    func configure(with content: OnboardingPage, currentPage: Int = 0) {
        titleLabel.attributedText = Font.heading4.compose(content.title, color: .dark100)
        descriptionLabel.attributedText = Font.body.compose(content.description, color: .dark80)

        pageControl.currentPage = currentPage

        imageView.image = content.image ?? UIImage(systemName: "photo")
        imageView.tintColor = .lightGray
    }
    
    func updateCurrentPage(_ page: Int) {
        pageControl.currentPage = page
    }
} 
