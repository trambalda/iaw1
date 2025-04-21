import UIKit

struct MenuItemListModel: Codable {
    
    let id: Int
    let image: String
    let name: String
    let price: Float
    let menuId: Int?
    
    static let empty = MenuItemListModel(
        id: 0,
        image: "",
        name: "",
        price: 0.0,
        menuId: 0
    )
}

extension MenuItemListModel {
    
    static let mockArray: [MenuItemListModel] = [
        MenuItemListModel(
            id: 1,
            image: "burgersmall",
            name: "Classic Cheese Hamburger (400 Cals)",
            price: 5.80,
            menuId: 1
        ),
        MenuItemListModel(
            id: 2,
            image: "burgersmall2",
            name: "Simply Cheese with Sesame Seed buns",
            price: 4.80,
            menuId: 2
        ),
        MenuItemListModel(
            id: 3,
            image: "sandwichsmall",
            name: "Veggie & Bacon Hot Sauce Sandwich ",
            price: 6.80,
            menuId: 3
        ),
        MenuItemListModel(
            id: 4,
            image: "burgersmall3",
            name: "Western BBQ Cheeseburger",
            price: 5.80,
            menuId: 4
        ),
        MenuItemListModel(
            id: 5,
            image: "saladsmall",
            name: "Bacon and Veggies Salad",
            price: 5.80,
            menuId: 5
        )
    ]
}
