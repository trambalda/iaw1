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
    let menuItemList: [MenuItemListModel]
    
    static let empty = RestaurantModel(
        image: nil,
        logo: nil,
        title: "",
        location: "",
        rating: "",
        time: "",
        typeOfFood: "",
        menu: [],
        menuItemList: []
    )
}

extension RestaurantModel {
    
    static let mock = RestaurantModel(
        image: .restaurant,
        logo: .logo,
        title: "McDonald's",
        location: "Bramlea & Sandalwood",
        rating: "4.5", time: "15-20",
        typeOfFood: "Burgers",
        menu: MenuModel.mock,
        menuItemList: MenuItemListModel.mockArray
    )
}
