import UIKit

final class OnboardingViewController: UIViewController {
    
    var appCoordinator: AppCoordinator?
    
    private var onboardingView: OnboardingView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .light100
        
        onboardingView = OnboardingView(pages: OnboardingPageModel.pages)
        onboardingView?.onFinish = { [weak self] in
            self?.finishOnboarding()
        }
        
        if let onboardingView {
            onboardingView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(onboardingView)
            
            NSLayoutConstraint.activate([
                onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
                onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            finishOnboarding()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar()
    }
    
    private func hideTabBar() {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.customTabBarHidden = true
        }
        navigationController?.isNavigationBarHidden = true
    }
    
    private func showTabBar() {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.customTabBarHidden = false
        }
    }
    
    private func finishOnboarding() {
        appCoordinator?.finishOnboarding()
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationController?.popViewController(animated: true)
        }
    }
} 
