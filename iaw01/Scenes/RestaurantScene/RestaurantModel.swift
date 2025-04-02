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

extension RestaurantModel {
    static let mock = RestaurantModel(image: .restaurant,
                                      logo: .logo,
                                      title: "McDonald's",
                                      location: "Bramlea & Sandalwood",
                                      rating: "4.5", time: "15-20",
                                      typeOfFood: "Burgers")
}
