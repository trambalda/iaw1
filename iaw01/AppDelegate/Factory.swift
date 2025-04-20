class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol
    
    init() {
        self.imageService = ImageService()
        self.networkService = NetworkService()
    }
    
    func createRestaurantScene() -> RestaurantViewController {
        let vc = RestaurantViewController()
        return vc
    }
}
