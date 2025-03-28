import UIKit

final class OnboardingView: UIView {
    
    private var pageViews: [OnboardingPageView] = []
    
    var onNextButtonTap: (() -> Void)?
    var onSkipButtonTap: (() -> Void)?
    var onPageChanged: ((Int) -> Void)?
    
    private var illustrationHeight: CGFloat {
        Screen.isIPhoneSE ? 250 : 350
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = OnboardingPage.count
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        scrollView.delegate = self
        
        setupLayout()
        setupConstraints()
        setupPages()
        setupActions()
        
        configure(with: 0)
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        addSubview(buttonsStackView)
        
        scrollView.addSubview(contentStackView)
        buttonsStackView.addArrangedSubview(skipButton)
        buttonsStackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(OnboardingPage.count)),

            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 64)
        ])

        let skipButtonWidth = skipButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.40)
        skipButtonWidth.priority = .defaultHigh
        skipButtonWidth.isActive = true
        
        let nextButtonWidth = nextButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.55)
        nextButtonWidth.priority = .defaultHigh
        nextButtonWidth.isActive = true
    }
    
    private func setupPages() {
        for index in 0..<OnboardingPage.count {
            let content = OnboardingPage.pages[index]
            let pageView = createPageView(with: content)
            pageViews.append(pageView)
            contentStackView.addArrangedSubview(pageView)
            
            pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
    }
    
    private func createPageView(with content: OnboardingPage) -> OnboardingPageView {
        let pageView = OnboardingPageView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.configure(with: content)
        return pageView
    }
    
    private func setupActions() {
        nextButton.onTap = { [weak self] in
            self?.onNextButtonTap?()
        }
        
        skipButton.onTap = { [weak self] in
            self?.onSkipButtonTap?()
        }
    }
    
    func configure(with page: Int) {
        for (_, pageView) in pageViews.enumerated() {
            pageView.updateCurrentPage(page)
        }
        
        nextButton.setTitle(OnboardingPage.isLastPage(page) ? "Continue" : "Next")
        
        let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        configure(with: page)
        onPageChanged?(page)
    }
} 
