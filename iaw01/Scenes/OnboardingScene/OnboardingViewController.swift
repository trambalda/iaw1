import UIKit

final class OnboardingViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinator?
    private var onboardingView: OnboardingView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        onboardingView = OnboardingView(pages: OnboardingPageModel.pages)
        onboardingView?.onFinish = { [weak self] in
            self?.finishOnboarding()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        if let onboardingView {
            view = onboardingView
        } else {
            finishOnboarding()
        }
    }

    private func finishOnboarding() {
        navigationController?.popViewController(animated: true)
        coordinator?.hideOnboardingScene()
    }
} 
