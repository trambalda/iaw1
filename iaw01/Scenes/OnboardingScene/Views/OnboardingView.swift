import UIKit

final class OnboardingView: UIView {

    var onNextButtonTap: (() -> Void)?
    var onSkipButtonTap: (() -> Void)?
    var onPageChanged: ((Int) -> Void)?

    private let pages: [OnboardingPageModel]
    
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
            self?.onNextButtonTap?()
        }
        return button
    }()
    
    private lazy var skipButton: CornersButton = {
        let button = CornersButton(style: .skipButton)
        button.onTap = { [weak self] in
            self?.onSkipButtonTap?()
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

    init(pages: [OnboardingPageModel], frame: CGRect = .zero) {
        self.pages = pages
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        self.pages = []
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .light100
        setupLayout()
        setupConstraints()
        changePage(on: 0)
    }

    func changePage(on pageNumber: Int) {
        let isLastPage = pageNumber == pages.count - 1
        nextButton.setTitle(isLastPage ? "Continue" : "Next")
        
        let contentOffset = CGPoint(x: scrollView.bounds.width * CGFloat(pageNumber), y: 0)
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
        contentStackView.arrangedSubviews.forEach { pageView in
            pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
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
            
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 64),
            
            nextButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.55)
        ])
    }
}

extension OnboardingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        changePage(on: pageNumber)
        onPageChanged?(pageNumber)
    }
} 
