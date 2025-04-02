import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {

    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?

    private let pages = OnboardingPageModel.pages
    private var currentPageNumber = 0

    private lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.pages = pages
        view.onPageChanged = { [weak self] pageNumber in
            self?.currentPageNumber = pageNumber
        }
        view.onNextButtonTap = { [weak self] in
            self?.switchToNextPage()
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

    private func switchToNextPage() {
        if currentPageNumber < pages.count - 1 {
            currentPageNumber += 1
            onboardingView.changePage(on: currentPageNumber)
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.isOnboardingCompletedKey)
        appCoordinator?.start()
    }
} 
