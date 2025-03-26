import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?
    
    private let onboardingView: OnboardingView
    private var currentPage = 0
    
    init() {
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
        onboardingView.setPageChangeAction { [weak self] page in
            self?.currentPage = page
        }
        
        onboardingView.setNextButtonAction { [weak self] in
            self?.handleNextButton()
        }
        
        onboardingView.setSkipButtonAction { [weak self] in
            self?.finishOnboarding()
        }
        
        onboardingView.configure(with: currentPage)
    }
    
    private func handleNextButton() {
        if currentPage < OnboardingPage.count - 1 {
            currentPage += 1
            onboardingView.configure(with: currentPage)
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.UserDefaults.isOnboardingCompleted.key)
        appCoordinator?.start()
    }
} 
