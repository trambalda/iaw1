import Foundation

struct RestaurantDto: Decodable {
    
    let id: Int
    let logo: String
    let name: String
    let image: String
    let rating: Double
    let deliveryTime: String
    let address: String
    let cousines: [String]
    let menu: [MenuDto]  
    let dishes: [MenuItemListDto]  
}
