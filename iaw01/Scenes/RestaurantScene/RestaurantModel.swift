import UIKit

struct RestaurantModel {
    
    let image: UIImage?
    let logo: UIImage?
    let title: String
    let location: String
    let rating: String
    let time: String
    let typeOfFood: String
    let menu: [MenuModel]
    
    static let empty = RestaurantModel(image: UIImage(systemName: "photo"),
                                       logo: UIImage(systemName: "photo"),
                                       title: "Название ресторана",
                                       location: "Адрес ресторана",
                                       rating: "Нет данных",
                                       time: "Нет данных",
                                       typeOfFood: "Нет данных",
                                       menu: [])
}

extension RestaurantModel {
    
    static let mock = RestaurantModel(image: .restaurant,
                                      logo: .logo,
                                      title: "McDonald's",
                                      location: "Bramlea & Sandalwood",
                                      rating: "4.5", time: "15-20",
                                      typeOfFood: "Burgers",
                                      menu: MenuModel.mock)
}
