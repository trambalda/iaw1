import UIKit

protocol RestaurantNetworkServiceProtocol {
    func fetchRestaurant(id: Int) async throws -> [RestaurantDto]
}

final class RestaurantNetworkService: RestaurantNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchRestaurant(id: Int) async throws -> [RestaurantDto] {
        let endpoint = "/restaurants"
        let params: [String: Any] = ["id": id]
        
        let response: [RestaurantDto] = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .get,
            params: params
        )
        
        return response
    }
}
