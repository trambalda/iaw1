import UIKit

struct MenuItemListModel {
    let foodImage: UIImage?
    let foodTitle: String
    let oldPrice: String
    let newPrice: String
    
    static let empty = MenuItemListModel(foodImage: UIImage(systemName: "photo"),
                                         foodTitle: "Нет данных",
                                         oldPrice: "-",
                                         newPrice: "-")
}

extension MenuItemListModel {
    static let mock = MenuItemListModel(foodImage: .burgersmall,
                                        foodTitle: "Classic Cheese Hamburger (400 Cals)",
                                        oldPrice: "5.80",
                                        newPrice: "4.59")
}
