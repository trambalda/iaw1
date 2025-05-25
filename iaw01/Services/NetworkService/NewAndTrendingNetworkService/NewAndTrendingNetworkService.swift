import UIKit

protocol TrendingNetworkServiceProtocol {
    func fetchItems(id: Int) async throws -> [NewAndTrendingDto]
}

final class TrendingNetworkService: TrendingNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // TODO: заменить endpoint при появлении бэка
    func fetchItems(id: Int) async throws -> [NewAndTrendingDto] {
        let endpoint = "/"
        let params: [String: Any] = [
            "id": id
        ]
        let response: [NewAndTrendingDto] = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .get,
            params: params
        )
        return response
    }
}

