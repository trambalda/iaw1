class Factory {
    
    let imageService: ImageServiceProtocol
    let networkService: NetworkServiceProtocol
    let keyboardService: KeyboardServiceProtocol

    init() {
        self.imageService = ImageService()
        self.networkService = NetworkService()
        self.keyboardService = KeyboardService()
    }
}
