import UIKit

protocol AuthorizationNetworkServiceProtocol {
    func login(email: String, password: String) async throws -> AuthorizationDto
    func register(email: String, phone: String, password: String) async throws -> AuthorizationDto
}

//final class AuthorizationNetworkService: AuthorizationNetworkServiceProtocol {
//    
//    private let networkService: NetworkServiceProtocol
//    
//    init(networkService: NetworkServiceProtocol) {
//        self.networkService = networkService
//    }
//    
//    func login(email: String, password: String) async throws -> AuthorizationDto {
//        let endpoint = "/authorization/login"
//        let param: [String: Any] = [
//            "email": email,
//            "password": password
//        ]
//        
//        let response: AuthorizationDto = try await networkService.request(
//            endpoint,
//            host: Constants.host,
//            httpMethod: .post,
//            params: param
//        )
//        return response
//    }
//    
//    func register(email: String, phone: String, password: String) async throws -> AuthorizationDto {
//        let endpoint = "/authorization/register"
//        let params: [String: Any] = [
//            "email": email,
//            "phone": phone,
//            "password": password
//        ]
//        
//        let response: AuthorizationDto = try await networkService.request(
//            endpoint,
//            host: Constants.host,
//            httpMethod: .post,
//            params: params
//        )
//        return response
//    }
//}

final class MockAuthorizationNetworkService: AuthorizationNetworkServiceProtocol {
    
    func login(email: String, password: String) async throws -> AuthorizationDto {
        guard
             email == "test@test.com",
             password == "12345"
        else {
            throw NSError(domain: "MockLogin", code: 401, userInfo: [NSLocalizedDescriptionKey: "incorrect data"])
        }
        
        return AuthorizationDto(
            userId: "mockUser1",
            token: "mockToken1",
            phone: "123456789"
        )
    }
    
    func register(email: String, phone: String, password: String) async throws -> AuthorizationDto {
        return AuthorizationDto(
            userId: "mockUser2",
            token: "mockToken2",
            phone: "987654321"
        )
    }
}
