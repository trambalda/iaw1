import Foundation

extension NSError {
    static func userError(with message: String, domain: String = Constants.restaurantDomain) -> NSError {
        NSError(
            domain: domain,
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }
}
