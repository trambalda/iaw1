import UIKit

struct MenuItemListModel {
    
    let foodImage: UIImage?
    let foodTitle: String
    let oldPrice: String
    let newPrice: String
    
    static let empty = MenuItemListModel(
        foodImage: nil,
        foodTitle: "",
        oldPrice: "",
        newPrice: ""
    )
}

extension MenuItemListModel {
    
    static let mockArray: [MenuItemListModel] = [
        MenuItemListModel(
            foodImage: .burgersmall,
            foodTitle: "Classic Cheese Hamburger (400 Cals)",
            oldPrice: "5.80",
            newPrice: "4.59"
        ),
        MenuItemListModel(
            foodImage: .burgersmall2,
            foodTitle: "Simply Cheese with Sesame Seed buns",
            oldPrice: "4.80",
            newPrice: "3.59"
        ),
        MenuItemListModel(
            foodImage: .sandwichsmall,
            foodTitle: "Veggie & Bacon Hot Sauce Sandwich ",
            oldPrice: "6.80",
            newPrice: "5.59"
        ),
        MenuItemListModel(
            foodImage: .burgersmall3,
            foodTitle: "Western BBQ Cheeseburger",
            oldPrice: "5.80",
            newPrice: "4.59"
        ),
        MenuItemListModel(
            foodImage: .saladsmall,
            foodTitle: "Bacon and Veggies Salad",
            oldPrice: "5.80",
            newPrice: "4.59"
        )
    ]
}
