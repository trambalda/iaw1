import UIKit

struct DishCellModel {
    let foodImage: UIImage?
    let foodTitle: String
    let restaurantImage: UIImage?
    let restaurantTitle: String
    
    static let empty = DishCellModel(foodImage: nil, foodTitle: "", restaurantImage: nil, restaurantTitle: "")
}
