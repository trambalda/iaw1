import Foundation

struct RestaurantsModel {
    
    let data: [RestaurantModel]
    let isSuccess: Bool
}

struct RestaurantModel {
    
    let id: Int
    let logoURL: URL?
    let name: String
    let imageURL: URL?
    let rating: Double
    let deliveryTime: String
    let address: String
    let cousines: String
    let menu: [MenuModel]
    let dishes: [MenuItemListModel] 
    
    static let empty = RestaurantModel(
        id: 0,
        logoURL: nil,
        name: "",
        imageURL: nil,
        rating: 0.0,
        deliveryTime: "",
        address: "",
        cousines: "",
        menu: [],
        dishes: []
    )
}

extension RestaurantsDto {
    
    func toModel() -> RestaurantsModel {
        return RestaurantsModel(
            data: data.map { $0.toModel() },
            isSuccess: isSuccess
        )
    }
}

extension RestaurantDto {
    
    func toModel() -> RestaurantModel {
        return RestaurantModel(
            id: id,
            logoURL: URL(string: logo),
            name: name,
            imageURL: URL(string: image),
            rating: rating,
            deliveryTime: deliveryTime,
            address: address,
            cousines: cousines.joined(separator: ", "),
            menu: menu.map { $0.toModel() },
            dishes: dishes.map { $0.toModel() }
        )
    }
}
