import UIKit

protocol RestaurantNetworkServiceProtocol {
    func fetchRestaurant(id: Int) async throws -> RestaurantModel?
}

final class RestaurantNetworkService: RestaurantNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchRestaurant(id: Int) async throws -> RestaurantModel? {
        let endpoint = "/restaurants"
        let params: [String: Any] = ["id": id]
        
        print("Запрос отправлен: \(endpoint), параметры: \(params)")
        
        let response: RestaurantsDto = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .get,
            params: params
        )
        
        print(response)
        return response.data.first?.toModel()
    }
}
