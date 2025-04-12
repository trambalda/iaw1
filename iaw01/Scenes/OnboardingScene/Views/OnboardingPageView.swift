import UIKit

final class OnboardingPageView: UIView {

    private let illustrationContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .light80
        view.layer.cornerRadius = 16
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
        pageControl.isUserInteractionEnabled = false
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

    private var verticalStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private lazy var contentStackView = verticalStackView

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(contentStackView)
        illustrationContainer.addSubview(imageView)
        contentStackView.addArrangedSubview(illustrationContainer)
        contentStackView.addArrangedSubview(pageControl)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        let illustrationHeight: CGFloat = Constants.isIPhoneSE ? 250 : 367
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            illustrationContainer.heightAnchor.constraint(equalToConstant: illustrationHeight),
            
            imageView.topAnchor.constraint(equalTo: illustrationContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: illustrationContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: illustrationContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: illustrationContainer.bottomAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor)
        ])
    }

    func configure(with content: OnboardingPageModel, allPages: [OnboardingPageModel], currentPage: Int = 0) {
        pageControl.numberOfPages = allPages.count
        pageControl.currentPage = currentPage
        
        titleLabel.attributedText = Font.heading4.compose(content.title, color: .dark100)
        descriptionLabel.attributedText = Font.body.compose(content.description, color: .dark80)
        imageView.image = content.image ?? UIImage(systemName: "photo")
        imageView.tintColor = .lightGray
    }
    
    func configure(with pages: [OnboardingPageModel]) {
        pageControl.numberOfPages = pages.count
    }
    
    func updateCurrentPage(_ page: Int) {
        pageControl.currentPage = page
    }
} 
