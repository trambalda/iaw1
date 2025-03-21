import UIKit

final class OnboardingView: UIView {
    
    // MARK: - Properties
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.bounces = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var pageViews: [UIView] = []
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        return pageControl
    }()
    
    private lazy var nextButton: CornersButton = {
        let button = CornersButton(style: .nextButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: CornersButton = {
        let button = CornersButton(style: .skipButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        scrollView.delegate = self
        
        setupContainers()
        setupPages()
        setupButtons()
        
        configure(with: 0)
    }
    
    private func setupContainers() {
        addSubview(contentContainer)
        addSubview(buttonsContainer)
        
        contentContainer.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        buttonsContainer.addSubview(nextButton)
        buttonsContainer.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor),
                        
            scrollView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(3)),

            buttonsContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            buttonsContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 100),
            
            nextButton.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: -46),
            nextButton.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 183),
            
            skipButton.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: -46),
            skipButton.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 20),
            skipButton.widthAnchor.constraint(equalToConstant: 153)
        ])
    }
    
    private func setupPages() {
        for _ in 0...2 {
            let pageView = createPageView()
            pageViews.append(pageView)
            contentStackView.addArrangedSubview(pageView)
            
            pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
    }
    
    private func createPageView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let illustrationContainer = UIView()
        illustrationContainer.backgroundColor = .light80
        illustrationContainer.layer.cornerRadius = 20
        illustrationContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let illustrationLabel = UILabel()
        illustrationLabel.attributedText = Font.body.compose("ILLUSTRATION HERE", color: .dark80)
        illustrationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(illustrationContainer)
        illustrationContainer.addSubview(illustrationLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            illustrationContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            illustrationContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            illustrationContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            illustrationContainer.heightAnchor.constraint(equalToConstant: 367),
            
            illustrationLabel.centerXAnchor.constraint(equalTo: illustrationContainer.centerXAnchor),
            illustrationLabel.centerYAnchor.constraint(equalTo: illustrationContainer.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationContainer.bottomAnchor, constant: 72),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        return view
    }
    
    private func setupButtons() {
        nextButton.setTitle("Next")
        skipButton.setTitle("Skip")
    }
    
    // MARK: - Public Methods
    
    func configure(with page: Int) {
        pageControl.currentPage = page
        
        let titles = [
            "Wide range of Food Categories & more",
            "Free Deliveries for ONE MONTH!!",
            "Get started on Ordering your Food"
        ]
        
        let descriptions = [
            "Browse through our extensive list of restaurants and dishes, and when you're ready to order, simply add your desired items to your cart and checkout. It's that easy!",
            "Get your favorite meals delivered to your doorstep for free with our online food delivery app - enjoy a whole month of complimentary delivery!",
            "Please create an account or sign in to your existing account to start browsing our selection of delicious meals from your favorite restaurants."
        ]
        
        for (index, pageView) in pageViews.enumerated() {
            let titleLabel = pageView.subviews.first { $0 is UILabel && $0 != pageView.subviews.first } as? UILabel
            let descriptionLabel = pageView.subviews.last { $0 is UILabel } as? UILabel
            let pageControl = pageView.subviews.first { $0 is UIPageControl } as? UIPageControl
            
            titleLabel?.attributedText = Font.heading4.compose(titles[index], color: .dark100)
            descriptionLabel?.attributedText = Font.body.compose(descriptions[index], color: .dark80)
            pageControl?.currentPage = page
        }
        
        nextButton.setTitle(page == 2 ? "Continue" : "Next")
        
        let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    func setNextButtonAction(_ action: @escaping () -> Void) {
        nextButton.onTap = action
    }
    
    func setSkipButtonAction(_ action: @escaping () -> Void) {
        skipButton.onTap = action
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        configure(with: page)
    }
} 
