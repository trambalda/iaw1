import UIKit

struct RestaurantCellModel {
    let image: UIImage?
    let title: String
    let address: String
    
    static var empty = RestaurantCellModel(image: nil, title: "", address: "") 
}
