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
        let pages = OnboardingPageModel.pages
        let vc = OnboardingViewController(pages: pages)
        vc.appCoordinator = appCoordinator
        return vc
    }
}
