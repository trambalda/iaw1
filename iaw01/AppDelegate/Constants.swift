import UIKit

struct Constants {
    static let url404 = URL(string: "http://errorpage404.tilda.ws")!
    static let isSE = UIScreen.main.bounds.height == 667
    static let host = "http://localhost:8080"
    static let googleLoginURL: URL? = URL(string: "https://accounts.google.com/InteractiveLogin")
    static let appleLoginURL: URL? = URL(string: "https://account.apple.com")
    static let restaurantDomain = "com.foodDeliveryApp.restaurant"
}
