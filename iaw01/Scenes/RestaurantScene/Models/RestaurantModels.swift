import Foundation

final class RestaurantModels {
    
    enum LoadRestaurant {
        struct Request {}
        struct Response {
            let dto: RestaurantDto
        }
        struct ViewModel {
            let model: RestaurantModel
        }
    }
    
    enum ErrorModel {
        struct Response {
            let error: NSError
        }
        struct ViewModel {
            let errorDescription: String
        }
    }
}
