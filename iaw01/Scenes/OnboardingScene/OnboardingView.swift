import UIKit

final class OnboardingView: UIView {
    
    // MARK: - Публичные замыкания
    var onNextButtonTap: (() -> Void)?
    var onSkipButtonTap: (() -> Void)?
    var onPageChanged: ((Int) -> Void)?
    
    // MARK: - Приватные хранимые свойства
    private var pages: [OnboardingPage] = []
    private var pageViews: [OnboardingPageView] = []
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
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
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Lazy свойства
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
    
    // MARK: - Вычисляемые свойства
    private var illustrationHeight: CGFloat {
        Screen.isIPhoneSE ? 250 : 350
    }
    
    // MARK: - Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Приватные методы настройки
    private func setupLayout() {
        backgroundColor = .white
        scrollView.delegate = self
        
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(scrollView)
        mainStackView.addArrangedSubview(buttonsStackView)
        
        scrollView.addSubview(contentStackView)
        buttonsStackView.addArrangedSubview(skipButton)
        buttonsStackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            buttonsStackView.heightAnchor.constraint(equalToConstant: 64),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            nextButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.55)
        ])
    }
    
    private func setupPages() {
        for index in 0..<pages.count {
            let content = pages[index]
            let pageView = createPageView(with: content)
            pageViews.append(pageView)
            contentStackView.addArrangedSubview(pageView)
            
            pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        
        // Устанавливаем ширину contentStackView после добавления всех страниц
        contentStackView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor,
            multiplier: CGFloat(pages.count)
        ).isActive = true
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
    
    // MARK: - Публичные методы
    func configure(with pages: [OnboardingPage]) {
        self.pages = pages
        pageControl.numberOfPages = pages.count
        setupPages()
        configure(with: 0)
    }
    
    func configure(with page: Int) {
        for (_, pageView) in pageViews.enumerated() {
            pageView.updateCurrentPage(page)
        }
        
        let isLastPage = page == pages.count - 1
        nextButton.setTitle(isLastPage ? "Continue" : "Next")
        
        let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(page), y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        configure(with: page)
        onPageChanged?(page)
    }
} 
