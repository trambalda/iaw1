import UIKit

final class OnboardingPageView: UIView {
    
    var isIPhoneSE: Bool {
        UIScreen.main.bounds.height <= 667
    }
    
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
    
    private let illustrationLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Font.body.compose("ILLUSTRATION HERE", color: .dark80)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = OnboardingPage.count
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let illustrationHeight: CGFloat = 250
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        addSubview(contentStackView)
        
        // Настраиваем контейнер для иллюстрации
        if isIPhoneSE {
            illustrationContainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
        } else {
            illustrationContainer.heightAnchor.constraint(equalTo: illustrationContainer.widthAnchor).isActive = true
        }
        
        // Добавляем элементы в стек
        contentStackView.addArrangedSubview(illustrationContainer)
        contentStackView.addArrangedSubview(pageControl)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0)
        ])
    }
    
    func configure(with content: OnboardingPage, currentPage: Int = 0) {
        // Настраиваем текстовые данные
        titleLabel.attributedText = Font.heading4.compose(content.title, color: .dark100)
        descriptionLabel.attributedText = Font.body.compose(content.description, color: .dark80)
        
        // Настраиваем индикатор страниц
        pageControl.currentPage = currentPage
        
        // Настраиваем иллюстрацию
        imageView.image = content.image ?? UIImage(systemName: "photo")
        imageView.tintColor = .lightGray
        
        illustrationContainer.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: illustrationContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: illustrationContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: illustrationContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: illustrationContainer.bottomAnchor)
        ])
    }
    
    func updateCurrentPage(_ page: Int) {
        pageControl.currentPage = page
    }
} 
