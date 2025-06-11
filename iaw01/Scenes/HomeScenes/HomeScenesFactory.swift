final class HomeScenesFactory: Factory {
    
    let coordinator: HomeScenesCoordinator
    
    init(coordinator: HomeScenesCoordinator) {
        self.coordinator = coordinator
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
    
    func createAuthorizationScene() -> AuthorizationViewController {
        let vc = AuthorizationViewController()
        return vc
    }
    
    func createRestaurantScene(with id: Int) -> RestaurantViewController {
        let viewController = RestaurantViewController()
        let interactor = RestaurantInteractor(restaurantId: id)
        let presenter = RestaurantPresenter()
        
        viewController.interactor = interactor
        viewController.imageService = imageService
        interactor.presenter = presenter
        interactor.restaurantNetworkService = RestaurantNetworkService(networkService: networkService)
        presenter.viewController = viewController
        
        return viewController
    }
    
    func createOnboardingScene() -> OnboardingViewController {
        let vc = OnboardingViewController()
        vc.coordinator = coordinator
        return vc
    }
}
