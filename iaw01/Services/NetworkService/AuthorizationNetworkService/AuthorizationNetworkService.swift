import UIKit

protocol AuthorizationNetworkServiceProtocol {
    func login(email: String, password: String) async throws -> AuthorizationDto
    func register(name: String, phone: String, email: String, password: String) async throws -> AuthorizationDto
}

final class AuthorizationNetworkService: AuthorizationNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login(email: String, password: String) async throws -> AuthorizationDto {
        let endpoint = "/authorization/login"
        let param: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let response: AuthorizationDto = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .post,
            params: param
        )
        return response
    }
    
    func register(name: String, phone: String, email: String, password: String) async throws -> AuthorizationDto {
        let endpoint = "/authorization/register"
        let params: [String: Any] = [
            "name": name,
            "phone": phone,
            "email": email,
            "password": password
        ]
        
        let response: AuthorizationDto = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .post,
            params: params
        )
        return response
    }
}
