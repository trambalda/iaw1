import UIKit

struct RestaurantModel {
    let image: UIImage?
    let logo: UIImage?
    let title: String
    let location: String
    let rating: String
    let time: String
    let typeOfFood: String
    
    static let empty = RestaurantModel(image: nil, logo: nil, title: "", location: "", rating: "", time: "", typeOfFood: "")
}
