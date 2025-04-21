import UIKit

final class OnboardingView: UIView {

    var onFinish: (() -> Void)?
    
    private let pages: [OnboardingPageModel]
    private var currentPageNumber: Int = 0
    
    private lazy var pageViews: [OnboardingPageView] = {
        var views = [OnboardingPageView]()
        
        for index in 0..<pages.count {
            let content = pages[index]
            
            let pageView = OnboardingPageView()
            pageView.translatesAutoresizingMaskIntoConstraints = false
            pageView.configure(with: content, allPages: pages, currentPage: index)
            
            views.append(pageView)
        }
        
        return views
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nextButton: CornersButton = {
        let button = CornersButton(style: .nextButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.onTap = { [weak self] in
            self?.switchToNextPage()
        }
        return button
    }()
    
    private lazy var skipButton: CornersButton = {
        let button = CornersButton(style: .skipButton)
        button.onTap = { [weak self] in
            self?.onFinish?()
        }
        return button
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init?(pages: [OnboardingPageModel], frame: CGRect = .zero) {
        guard !pages.isEmpty else { return nil }
        self.pages = pages
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        changePage(on: 0)
    }

    private func switchToNextPage() {
        if currentPageNumber < pages.count - 1 {
            currentPageNumber += 1
            changePage(on: currentPageNumber)
        } else {
            onFinish?()
        }
    }

    func changePage(on pageNumber: Int) {
        currentPageNumber = pageNumber
        let isLastPage = pageNumber == pages.count - 1
        nextButton.setTitle(isLastPage ? "Continue" : "Next")
        
        let pageWidth = UIScreen.main.bounds.width
        let contentOffset = CGPoint(x: pageWidth * CGFloat(pageNumber), y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        pageViews.forEach { pageView in
            contentStackView.addArrangedSubview(pageView)
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(skipButton)
        buttonsStackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: -16),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -16),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 64),
            
            nextButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.55)
        ])
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = UIScreen.main.bounds.width
        let pageNumber = Int(scrollView.contentOffset.x / pageWidth)
        changePage(on: pageNumber)
    }
} 
