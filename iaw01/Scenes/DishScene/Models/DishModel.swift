import UIKit

enum DishType {
    
    case combo
    case customizable
    case fixed
}

struct DrinkCategory {
    
    let name: String
    let options: [String]
}

struct DishModel {
    
    let id: Int
    let image: UIImage?
    let name: String
    let calories: String
    let type: DishType
    let sideItems: [String]?
    let drinks: [DrinkCategory]?
    let editableIngredients: [String]?
    
    static let empty = DishModel(
        id: 0,
        image: nil,
        name: "",
        calories: "",
        type: .combo,
        sideItems: [],
        drinks: [],
        editableIngredients: []
    )
}

extension DishModel {
    
    static let mock = DishModel(
        id: 1,
        image: .dish,
        name: "Western BBQ Cheeseburger Meal",
        calories: "340-400 Cals",
        type: .combo,
        sideItems: ["Medium Fries", "Large Fries"],
        drinks: [
            DrinkCategory(name: "Soft Drinks", options: ["Coke", "Pepsi", "Sprite"]),
            DrinkCategory(name: "Juices", options: ["Fruit Punch Juice", "Orange Juice", "Ginger Shot Juice", "Sweet Guava Juice", "Tangy Tomato Juice"])
        ],
        editableIngredients: ["Sesame Seed Bun", "BBQ Sauce", "Beef Patty", "Cheese", "Banana Peppers", "Lettuce", "Chipotie Sauce", "Sesame Seed Bun"]
    )
}
