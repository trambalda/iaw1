class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol

    init() {
        self.imageService = ImageService()
        self.networkService = NetworkService()
    }
}
