import UIKit

final class OnboardingViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinator?
    private var onboardingView: OnboardingView?
    
    override func loadView() {
        if let view = OnboardingView(pages: OnboardingPageModel.pages) {
            view.onFinish = { [weak self] in
                self?.finishOnboarding()
            }
            self.view = view
            self.onboardingView = view
        } else {
            finishOnboarding()
        }
    }

    private func finishOnboarding() {
        coordinator?.hideOnboardingScene()
    }
} 
