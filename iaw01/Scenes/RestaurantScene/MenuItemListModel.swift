import UIKit

struct MenuItemListModel {
    let foodImage: UIImage?
    let foodTitle: String?
    let oldPrice: String?
    let newPrice: String?
    
    static let empty = MenuItemListModel(foodImage: nil, foodTitle: "", oldPrice: "", newPrice: "")
}
