import UIKit

struct MenuItemListModel: Codable {
    
    let id: Int
    let image: String
    let name: String
    let price: Float
    let weight: Int
    
    static let empty = MenuItemListModel(
        id: 0,
        image: "",
        name: "",
        price: 0.0,
        weight: 0
    )
}
