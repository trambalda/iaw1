import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?
    
    private let onboardingView: OnboardingView
    private var currentPage = 0
    private let pages: [OnboardingPage]
    
    init(pages: [OnboardingPage] = OnboardingPage.pages) {
        self.pages = pages
        onboardingView = OnboardingView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardingView()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupOnboardingView() {
        setupUI()
        setupActions()
        onboardingView.configure(with: pages)
    }
    
    private func setupUI() {
        onboardingView.onPageChanged = { [weak self] page in
            self?.currentPage = page
        }
    }
    
    private func setupActions() {
        onboardingView.onNextButtonTap = { [weak self] in
            self?.handleNextButton()
        }
        
        onboardingView.onSkipButtonTap = { [weak self] in
            self?.finishOnboarding()
        }
    }
    
    private func handleNextButton() {
        if currentPage < pages.count - 1 {
            currentPage += 1
            onboardingView.configure(with: currentPage)
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isOnboardingCompletedKey)
        appCoordinator?.start()
    }
} 
