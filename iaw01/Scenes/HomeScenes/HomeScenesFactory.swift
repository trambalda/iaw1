final class HomeScenesFactory {
    
    let coordinator: HomeScenesCoordinator
    private var factory: Factory?
    
    init(coordinator: HomeScenesCoordinator) {
        self.coordinator = coordinator
        if let appCoordinator = coordinator.appCoordinator {
            self.factory = Factory(appCoordinator: appCoordinator)
        }
    }
    
    func createDummyScene() -> DummyViewController {
        let vc = DummyViewController()
        vc.coordinator = coordinator
        return vc
    }
    
    func createTextFieldsScene() -> TextFieldsViewController {
        let vc = TextFieldsViewController()
        return vc
    }
    
    func createCornersButtonsScene() -> CornersButtonsViewController {
        let vc = CornersButtonsViewController()
        return vc
    }
    
    func createVerifyPhoneNumberScene() -> VerifyPhoneNumberViewController {
        let vc = VerifyPhoneNumberViewController()
        return vc
    }
    
    func createOnboardingScene() -> OnboardingViewController {
        if let factory = factory {
            let vc = factory.createOnboardingScene()
            if vc.appCoordinator == nil, let appCoordinator = coordinator.appCoordinator {
                vc.appCoordinator = appCoordinator
            }
            return vc
        } else {
            // Создаем OnboardingViewController напрямую, если Factory недоступен
            let pages = OnboardingPageModel.pages
            let vc = OnboardingViewController(pages: pages)
            vc.appCoordinator = coordinator.appCoordinator
            return vc
        }
    }
}
