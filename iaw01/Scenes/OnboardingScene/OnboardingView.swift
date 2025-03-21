import UIKit

final class OnboardingView: UIView {
    
    // MARK: - Properties
    
    private let illustrationContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .light100
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let illustrationLabel: UILabel = {
        let label = UILabel()
        label.text = "ILLUSTRATION HERE"
        label.attributedText = Font.body.compose("ILLUSTRATION HERE", color: .dark80)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.currentPageIndicatorTintColor = .peach100
        pageControl.pageIndicatorTintColor = .light80
        
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
        layer.cornerRadius = 46
        
        addSubview(illustrationContainer)
        illustrationContainer.addSubview(illustrationLabel)
        addSubview(pageControl)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(nextButton)
        addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            illustrationContainer.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            illustrationContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            illustrationContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            illustrationContainer.heightAnchor.constraint(equalToConstant: 367),
            
            illustrationLabel.centerXAnchor.constraint(equalTo: illustrationContainer.centerXAnchor),
            illustrationLabel.centerYAnchor.constraint(equalTo: illustrationContainer.centerYAnchor),
            
            pageControl.topAnchor.constraint(equalTo: illustrationContainer.bottomAnchor, constant: 30),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 29),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -46),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            nextButton.widthAnchor.constraint(equalToConstant: 183),
            
            skipButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -46),
            skipButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            skipButton.widthAnchor.constraint(equalToConstant: 153)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(with page: Int) {
        pageControl.currentPage = page
        
        switch page {
        case 0:
            titleLabel.attributedText = Font.heading2.compose("Wide range of Food Categories & more", color: .dark100)
            descriptionLabel.attributedText = Font.body.compose("Browse through our extensive list of restaurants and dishes, and when you're ready to order, simply add your desired items to your cart and checkout. It's that easy!", color: .dark80)
            nextButton.setTitle("Next")
            
        case 1:
            titleLabel.attributedText = Font.heading2.compose("Free Deliveries for ONE MONTH!!", color: .dark100)
            descriptionLabel.attributedText = Font.body.compose("Get your favorite meals delivered to your doorstep for free with our online food delivery app - enjoy a whole month of complimentary delivery!", color: .dark80)
            nextButton.setTitle("Next")
            
        case 2:
            titleLabel.attributedText = Font.heading2.compose("Get started on Ordering your Food", color: .dark100)
            descriptionLabel.attributedText = Font.body.compose("Please create an account or sign in to your existing account to start browsing our selection of delicious meals from your favorite restaurants.", color: .dark80)
            nextButton.setTitle("Continue")
            
        default:
            break
        }
    }
    
    func setNextButtonAction(_ action: @escaping () -> Void) {
        nextButton.onTap = action
    }
    
    func setSkipButtonAction(_ action: @escaping () -> Void) {
        skipButton.onTap = action
    }
} 
