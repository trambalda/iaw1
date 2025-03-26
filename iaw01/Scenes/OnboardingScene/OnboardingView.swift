import UIKit

final class OnboardingView: UIView {
    
    private var pageViews: [OnboardingPageView] = []
    private var onPageChanged: ((Int) -> Void)?
    
    private var illustrationHeight: CGFloat {
        Constants.Screen.isIPhoneSE ? 250 : 350
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
        
        setupContainers()
        setupPages()
        setupButtons()
        
        configure(with: 0)
    }
    
    private func setupContainers() {
        // Добавляем элементы напрямую на view, без использования mainStackView
        addSubview(scrollView)
        addSubview(buttonsStackView)
        
        scrollView.addSubview(contentStackView)
        buttonsStackView.addArrangedSubview(skipButton)
        buttonsStackView.addArrangedSubview(nextButton)
        
        NSLayoutConstraint.activate([
            // Ограничения для scrollView
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
            
            // Ограничения для contentStackView внутри scrollView
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(OnboardingPage.count)),
            
            // Ограничения для buttonsStackView
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 64),
            
            // Высота кнопок
            skipButton.heightAnchor.constraint(equalToConstant: 64),
            nextButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        // Установка ширины кнопок
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
        
        contentStackView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor, 
            multiplier: CGFloat(OnboardingPage.count)
        )
        .isActive = true
    }
    
    private func createPageView(with content: OnboardingPage) -> OnboardingPageView {
        let pageView = OnboardingPageView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.configure(with: content)
        return pageView
    }
    
    private func setupButtons() {
        nextButton.setTitle("Next")
        skipButton.setTitle("Skip")
    }
    
    func configure(with page: Int) {
        for (_, pageView) in pageViews.enumerated() {
            pageView.updateCurrentPage(page)
        }
        
        nextButton.setTitle(OnboardingPage.isLastPage(page) ? "Continue" : "Next")
        
        let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    func setNextButtonAction(_ action: @escaping () -> Void) {
        nextButton.onTap = action
    }
    
    func setSkipButtonAction(_ action: @escaping () -> Void) {
        skipButton.onTap = action
    }
    
    func setPageChangeAction(_ action: @escaping (Int) -> Void) {
        onPageChanged = action
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        configure(with: page)
        onPageChanged?(page)
    }
} 
