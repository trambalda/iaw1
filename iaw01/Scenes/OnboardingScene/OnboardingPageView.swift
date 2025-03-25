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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
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
        
        // Настраиваем констрейнты
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            
            illustrationContainer.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            illustrationContainer.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor)
        ])
    }
    
    func configure(with content: OnboardingPage, currentPage: Int = 0) {
        // Настраиваем текстовые данные
        titleLabel.attributedText = Font.heading4.compose(content.title, color: .dark100)
        descriptionLabel.attributedText = Font.body.compose(content.description, color: .dark80)
        
        // Настраиваем индикатор страниц
        pageControl.currentPage = currentPage
        
        // Настраиваем иллюстрацию
        if let image = content.image {
            imageView.image = image
            illustrationLabel.isHidden = true
            
            illustrationContainer.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: illustrationContainer.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: illustrationContainer.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: illustrationContainer.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: illustrationContainer.bottomAnchor)
            ])
        } else {
            imageView.isHidden = true
            illustrationLabel.isHidden = false
            
            illustrationContainer.addSubview(illustrationLabel)
            NSLayoutConstraint.activate([
                illustrationLabel.centerXAnchor.constraint(equalTo: illustrationContainer.centerXAnchor),
                illustrationLabel.centerYAnchor.constraint(equalTo: illustrationContainer.centerYAnchor)
            ])
        }
    }
    
    func updateCurrentPage(_ page: Int) {
        pageControl.currentPage = page
    }
} 
