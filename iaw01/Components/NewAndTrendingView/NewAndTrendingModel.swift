import UIKit

struct NewAndTrendingModel {
    let id: Int
    let foodImageURL: URL?
    let restaurantImageURL: URL?
    let restaurantTitle: String
    let distance: String
    
    static let empty = NewAndTrendingModel(
        id: 0,
        foodImageURL: nil,
        restaurantImageURL: nil,
        restaurantTitle: "",
        distance: ""
    )
}

extension NewAndTrendingDto {
    var model: NewAndTrendingModel {
        NewAndTrendingModel(
            id: id,
            foodImageURL: URL(string: foodImage),
            restaurantImageURL: URL(string: restaurantImage),
            restaurantTitle: restaurantTitle,
            distance: distance
        )
    }
}
