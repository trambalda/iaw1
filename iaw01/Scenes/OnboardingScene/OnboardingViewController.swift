import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contentView: OnboardingView
    private var currentPage = 0
    weak var delegate: OnboardingViewControllerDelegate?
    
    // MARK: - Init
    
    init() {
        contentView = OnboardingView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        contentView.configure(with: currentPage)
    }
    
    // MARK: - Private Methods
    
    private func setupActions() {
        contentView.setNextButtonAction { [weak self] in
            self?.handleNextButton()
        }
        
        contentView.setSkipButtonAction { [weak self] in
            self?.finishOnboarding()
        }
    }
    
    private func handleNextButton() {
        if currentPage < 2 {
            currentPage += 1
            contentView.configure(with: currentPage)
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        // TODO: Сохранить флаг о том, что онбординг пройден
        // UserDefaults.standard.set(true, forKey: "OnboardingCompleted")
        delegate?.onboardingDidFinish()
    }
} 