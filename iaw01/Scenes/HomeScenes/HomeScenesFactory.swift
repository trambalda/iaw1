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
    
    func createRestaurantScene(with id: Int) -> RestaurantViewController {
        let networkService = NetworkService()
        let restaurantService = RestaurantNetworkService(networkService: networkService)
        let vc = RestaurantViewController(id: id, restaurantService: restaurantService)
        return vc
    }
}
