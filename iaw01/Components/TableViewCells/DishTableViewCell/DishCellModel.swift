import UIKit

struct DishCellModel {
    static var empty = DishCellModel(foodImage: nil, foodTitle: "", restaurantImage: nil, restaurantTitle: "")
    let foodImage: UIImage?
    let foodTitle: String
    let restaurantImage: UIImage?
    let restaurantTitle: String
}

