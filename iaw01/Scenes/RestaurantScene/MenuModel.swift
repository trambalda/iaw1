import UIKit

struct MenuModel {
    let title: String
    let categories: [String]
    
    static let empty = MenuModel(title: "", categories: [])
}

extension MenuModel {
    static let mock : [MenuModel] = [
        MenuModel(title: "Breakfast Menu",
                  categories: ["Pancakes", "Omelettes", "Coffee", "Juices"]),
        MenuModel(title: "Lunch & Dinner",
                  categories: ["Today's Deals", "Burger Meals", "Chicken & Fish", "Salads"]),
        MenuModel(title: "Overnight Menu",
                  categories: ["Late Night Snacks", "Wraps", "Desserts", "Drinks"])
    ]
}
