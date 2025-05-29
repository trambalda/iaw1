import Foundation

extension NSError {
    static func userError(with message: String, domain: String = Constants.restaurantDomain) -> NSError {
        return NSError(
            domain: domain,
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }
}
