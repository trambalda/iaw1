import UIKit

protocol OnboardingViewDelegate: AnyObject {
    func onboardingView(_ view: OnboardingView, didChangePage page: Int)
}

final class OnboardingView: UIView {
    
    weak var delegate: OnboardingViewDelegate?
    
    private var pageViews: [UIView] = []
    
    private var padding: CGFloat {
        return UIScreen.main.bounds.height > 800 ? 20 : 10
    }
    
    var screenAspectRatio: CGFloat {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width / screenSize.height
    }
    
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
        scrollView.bounces = false
        scrollView.isDirectionalLockEnabled = true
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
        pageControl.numberOfPages = OnboardingContent.count
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
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(OnboardingContent.count)),

            buttonsContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            buttonsContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            buttonsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 90),
            
            nextButton.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: -padding),
            nextButton.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: 0),
            nextButton.widthAnchor.constraint(equalTo: buttonsContainer.widthAnchor, multiplier: 0.55),
            
            skipButton.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: -padding),
            skipButton.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 0),
            skipButton.widthAnchor.constraint(equalTo: buttonsContainer.widthAnchor, multiplier: 0.40)
        ])
    }
    
    private func setupPages() {
        for index in 0..<OnboardingContent.count {
            let content = OnboardingContent.pages[index]
            let pageView = createPageView(with: content)
            pageViews.append(pageView)
            contentStackView.addArrangedSubview(pageView)
            
            pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        }
        
        contentStackView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor, 
            multiplier: CGFloat(OnboardingContent.count)
        )
        .isActive = true
    }
    
    private func createPageView(with content: OnboardingPage) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let illustrationContainer = UIView()
        illustrationContainer.backgroundColor = .light80
        illustrationContainer.layer.cornerRadius = 20
        illustrationContainer.clipsToBounds = true
        illustrationContainer.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = content.image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            illustrationContainer.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: illustrationContainer.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: illustrationContainer.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: illustrationContainer.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: illustrationContainer.bottomAnchor)
            ])
        } else {
            let illustrationLabel = UILabel()
            illustrationLabel.attributedText = Font.body.compose("ILLUSTRATION HERE", color: .dark80)
            illustrationLabel.translatesAutoresizingMaskIntoConstraints = false
            illustrationContainer.addSubview(illustrationLabel)
            
            NSLayoutConstraint.activate([
                illustrationLabel.centerXAnchor.constraint(equalTo: illustrationContainer.centerXAnchor),
                illustrationLabel.centerYAnchor.constraint(equalTo: illustrationContainer.centerYAnchor)
            ])
        }
        
        let pageControl = UIPageControl()
        pageControl.numberOfPages = OnboardingContent.count
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = Font.heading4.compose(content.title, color: .dark100)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = Font.body.compose(content.description, color: .dark80)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(illustrationContainer)
        view.addSubview(pageControl)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            illustrationContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            illustrationContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            illustrationContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            illustrationContainer.heightAnchor.constraint(equalTo: illustrationContainer.widthAnchor, multiplier: self.screenAspectRatio > 0.5 ? 0.8 : 1),
            
            pageControl.topAnchor.constraint(equalTo: illustrationContainer.bottomAnchor, constant: padding),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])

        return view
    }
    
    private func setupButtons() {
        nextButton.setTitle("Next")
        skipButton.setTitle("Skip")
    }
    
    func configure(with page: Int) {
        for (_, pageView) in pageViews.enumerated() {
            let pageControl = pageView.subviews.first { $0 is UIPageControl } as? UIPageControl
            pageControl?.currentPage = page
        }
        
        nextButton.setTitle(OnboardingContent.isLastPage(page) ? "Continue" : "Next")
        
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
        delegate?.onboardingView(self, didChangePage: page)
    }
} 
