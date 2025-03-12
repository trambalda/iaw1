import UIKit

enum RootTabBarItem {

    case home
    case discover
    case drivethru
    case orders
    case profile
    
    var title: String {
        switch self {
        case .home:      "Home"
        case .discover:  "Discover"
        case .drivethru: "Drivethru"
        case .orders:    "Orders"
        case .profile:   "Profile"
        }
    }
    
    var image: UIImage {
        switch self {
        case .home:      UIImage(resource: .home)
        case .discover:  UIImage(resource: .discover)
        case .drivethru: UIImage(resource: .drivethru)
        case .orders:    UIImage(resource: .orders)
        case .profile:   UIImage(resource: .profile)
        }
    }
}
