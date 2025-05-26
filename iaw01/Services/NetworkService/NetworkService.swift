import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ endpoint: String,
        host: String,
        httpMethod: HTTPMethod,
        params: [String: Any]
    ) async throws -> T
}

extension NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: String) async throws -> T {
        try await request(
            endpoint,
            host: Constants.host,
            httpMethod: HTTPMethod.get,
            params: [:]
        )
    }
}

struct NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(
        _ endpoint: String,
        host: String,
        httpMethod: HTTPMethod,
        params: [String: Any]
    ) async throws -> T {
        
        let request = try makeRequest(with: endpoint, host: host, httpMethod: httpMethod, params: params)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkServiceError.invalidResponse("Не удалось прочесть ответ сервера")
        }

        switch statusCode {
        case 200:
            let result = try JSONDecoder().decode(APIResponseDto<T>.self, from: data)

            if result.isSuccess, let data = result.data {
                return data
            } else {
                throw NetworkServiceError.invalidResponse(result.errorMessage)
            }
        default:
            throw NetworkServiceError.unknown
        }
    }
    
    private func makeRequest(
        with endpoint: String,
        host: String,
        httpMethod: HTTPMethod,
        params: [String: Any]
    ) throws -> URLRequest {
        guard var components = URLComponents(string: host + endpoint) else {
            throw NetworkServiceError.invalidURL
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        switch httpMethod {
        case .get:
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        case .post, .patch, .delete:
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                throw NetworkServiceError.invalidParams
            }
            request.httpBody = httpBody
        }
        return request
    }
}
