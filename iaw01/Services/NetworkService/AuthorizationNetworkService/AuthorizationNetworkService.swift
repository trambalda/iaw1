import UIKit

protocol AuthorizationNetworkServiceProtocol {
    func login(email: String, password: String) async throws -> String
    func register(name: String, phone: String, email: String, password: String) async throws -> String
}

final class AuthorizationNetworkService: AuthorizationNetworkServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login(email: String, password: String) async throws -> String {
        let endpoint = "/auth"
        let param: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let response: String = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .post,
            params: param
        )
        return response
    }
    
    func register(name: String, phone: String, email: String, password: String) async throws -> String {
        let endpoint = "/register"
        let cleanPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let params: [String: Any] = [
            "name": name,
            "phone": cleanPhone,
            "email": email,
            "password": password
        ]
        
        print("register params: \(params)")
        
        if !JSONSerialization.isValidJSONObject(params) {
            print("params невалидны для JSONSerialization")
        }
        
        for (key, value) in params {
            print("\(key): \(value) — \(type(of: value))")
        }
        
        let response: String = try await networkService.request(
            endpoint,
            host: Constants.host,
            httpMethod: .post,
            params: params
        )
        return response
    }
}
