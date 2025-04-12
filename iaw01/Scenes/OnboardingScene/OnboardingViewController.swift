import UIKit

final class OnboardingViewController: UIViewController {
    
    private let pages: [OnboardingPageModel]
    private let coordinator: OnboardingCoordinator
    
    private lazy var onboardingView: OnboardingView? = {
        let view = OnboardingView(pages: pages)
        view?.translatesAutoresizingMaskIntoConstraints = false
        view?.onFinish = { [weak self] in
            self?.finishOnboarding()
        }
        return view
    }()
    
    init(pages: [OnboardingPageModel], coordinator: OnboardingCoordinator) {
        self.pages = pages
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        if let onboardingView = onboardingView {
            view = onboardingView
        } else {
            finishOnboarding()
        }
    }
    
    private func finishOnboarding() {
        coordinator.finishOnboarding()
    }
} 
