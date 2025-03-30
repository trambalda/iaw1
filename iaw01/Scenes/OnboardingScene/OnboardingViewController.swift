import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {

    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?

    private let pages = OnboardingPage.pages
    private var currentPage = 0

    private lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.configure(with: pages)
        view.onPageChanged = { [weak self] page in
            self?.currentPage = page
        }
        view.onNextButtonTap = { [weak self] in
            self?.handleNextButton()
        }
        view.onSkipButtonTap = { [weak self] in
            self?.finishOnboarding()
        }
        return view
    }()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
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
