import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?
    
    private let contentView: OnboardingView
    private var currentPage = 0
    
    init() {
        contentView = OnboardingView()
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        contentView.configure(with: currentPage)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupView() {
        contentView.setPageChangeAction { [weak self] page in
            self?.currentPage = page
        }
    }
    
    private func setupActions() {
        contentView.setNextButtonAction { [weak self] in
            self?.handleNextButton()
        }
        
        contentView.setSkipButtonAction { [weak self] in
            self?.finishOnboarding()
        }
    }
    
    private func handleNextButton() {
        if currentPage < OnboardingPage.count - 1 {
            currentPage += 1
            contentView.configure(with: currentPage)
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: StoredVariables.isOnboardingCompleted.name)
        appCoordinator?.start()
    }
} 
