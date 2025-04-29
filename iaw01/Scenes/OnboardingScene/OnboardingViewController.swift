import UIKit

final class OnboardingViewController: UIViewController {
    
    var coordinator: HomeScenesCoordinator?
    private lazy var onboardingView: OnboardingView = {
        guard 
            let view = OnboardingView(pages: OnboardingPageModel.pages) 
        else {
            fatalError("Failed to initialize OnboardingView")
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.onFinish = { [weak self] in
            self?.finishOnboarding()
        }
    }
    
    override func loadView() {
        self.view = onboardingView
    }

    private func finishOnboarding() {
        navigationController?.popViewController(animated: true)
        coordinator?.hideOnboardingScene()
    }
} 
