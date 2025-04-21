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
        return factory!.createOnboardingScene()
    }
}
