import UIKit

struct RestaurantCellModel {
    static var empty = RestaurantCellModel(image: nil, title: "", address: "") 
    let image: UIImage?
    let title: String
    let address: String
}
