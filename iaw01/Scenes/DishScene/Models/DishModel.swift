import UIKit

struct DishModel {
    
    let image: UIImage?
    let name: String
    let calories: String
    
    static let empty = DishModel(
        image: nil,
        name: "",
        calories: ""
    )
    
}

extension DishModel {
    
    static let mock = DishModel(
        image: .dish,
        name: "Western BBQ Cheeseburger Meal",
        calories: "340-400 Cals"
    )
}
