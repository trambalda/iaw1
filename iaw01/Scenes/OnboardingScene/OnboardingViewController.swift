import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {
    
    // MARK: - Публичные свойства
    weak var delegate: OnboardingViewControllerDelegate?
    var appCoordinator: AppCoordinator?
    
    // MARK: - Приватные хранимые свойства
    private let pages: [OnboardingPage]
    private var currentPage = 0
    
    // MARK: - Lazy свойства
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
    
    // MARK: - Методы жизненного цикла
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Приватные методы
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
    
    // MARK: - Инициализаторы
    init(pages: [OnboardingPage] = OnboardingPage.pages) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 
