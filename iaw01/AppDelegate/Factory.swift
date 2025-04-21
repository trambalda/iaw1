class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol
    
    init() {
        self.imageService = ImageService()
        self.networkService = NetworkService()
    }
    
    func createOnboardingScene() -> OnboardingViewController {
        let pages = OnboardingPageModel.pages
        let vc = OnboardingViewController(pages: pages)
        vc.appCoordinator = appCoordinator
        return vc
    }
}
