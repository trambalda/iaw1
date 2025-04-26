import UIKit

protocol RestaurantServiceProtocol {
    func fetchRestaurant(id: Int) async throws -> RestaurantModel?
}

final class RestaurantService: RestaurantServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchRestaurant(id: Int) async throws -> RestaurantModel? {
        let response: [RestaurantModel] = try await networkService.request(
            "/restaurants",
            host: Constants.host,
            httpMethod: .get,
            params: ["id": id]
        )
        return response.first
    }
}
