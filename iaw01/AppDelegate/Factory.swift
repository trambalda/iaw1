class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol
    let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.imageService = ImageService()
        self.networkService = NetworkService()
        self.appCoordinator = appCoordinator
    }
    
    func createOnboardingScene() -> OnboardingViewController {
        let vc = OnboardingViewController()
        vc.appCoordinator = appCoordinator
        return vc
    }
}
