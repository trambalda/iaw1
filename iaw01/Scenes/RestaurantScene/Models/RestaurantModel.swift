import UIKit

struct RestaurantsModel: Codable {
    let data: [RestaurantModel]
    let isSuccess: Bool
}

struct RestaurantModel: Codable {
    
    let id: Int
    let logo: String
    let name: String
    let image: String
    let rating: Double
    let deliveryTime: String
    let address: String
    let cousines: [String]
    let menu: [MenuModel]
    let dishes: [MenuItemListModel]
    
    var cousinesString: String {
        cousines.joined(separator: ", ")
    }
    
    static let empty = RestaurantModel(
        id: 0,
        logo: "",
        name: "",
        image: "",
        rating: 0.0,
        deliveryTime: "",
        address: "",
        cousines: [],
        menu: [],
        dishes: []
    )
}

