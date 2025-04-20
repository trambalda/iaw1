import UIKit

protocol ImageServiceProtocol {
    func loadImage(from url: URL?) async throws -> UIImage
}

struct ImageService: ImageServiceProtocol {
    
    func loadImage(from url: URL?) async throws -> UIImage {
        guard let url else { return UIImage() }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw ImageServiceError.invalidData
        }
        
        return image
    }
    
    enum ImageServiceError: Error {
        case invalidData
    }
}
