import UIKit

struct RestaurantModel {
    
    let id: Int
    let logo: String
    let name: String
    let image: String
    let rating: Float
    let deliveryTime: String
    let address: String
    let cousines: [String]
    let menu: [MenuModel]
    let dishes: [MenuItemListModel]
    
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

extension RestaurantModel {
    
    static let mock = RestaurantModel(
        id: 0,
        logo: "logo",
        name: "McDonald's",
        image: "restaurant",
        rating: 4.5,
        deliveryTime: "15-20",
        address: "Bramlea & Sandalwood",
        cousines: ["Burgers"],
        menu: MenuModel.mock,
        dishes: MenuItemListModel.mockArray
    )
}
