import UIKit

final class OnboardingViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinator?
    
    private lazy var onboardingView: OnboardingView? = {
        let view = OnboardingView(pages: OnboardingPageModel.pages)
        view?.onFinish = { [weak self] in
            self?.finishOnboarding()
        }
        return view
    }()
    
    override func loadView() {
        if let onboardingView {
            self.view = onboardingView
        } else {
            finishOnboarding()
        }
    }

    private func finishOnboarding() {
        coordinator?.hideOnboardingScene()
    }
} 
