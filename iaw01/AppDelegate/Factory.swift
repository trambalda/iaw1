class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol
    let restaurantService: RestaurantServiceProtocol
    
    init() {
        self.imageService = ImageService()
        self.networkService = NetworkService()
        self.restaurantService = RestaurantService(networkService: networkService)
    }
}
