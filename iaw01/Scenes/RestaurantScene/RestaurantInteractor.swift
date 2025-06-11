import UIKit

protocol RestaurantBusinessLogic {
    func loadRestaurant()
}

final class RestaurantInteractor: RestaurantBusinessLogic {
    
    var presenter: RestaurantPresentationLogic?
    var restaurantNetworkService: RestaurantNetworkService?     
    private let restaurantId: Int
    
    init(restaurantId: Int) {
        self.restaurantId = restaurantId
    }
    
    func loadRestaurant() {
        guard let restaurantNetworkService else { return }
        Task {
            do {
                let dto = try await restaurantNetworkService.fetchRestaurant(id: restaurantId)
                if dto.isEmpty {
                    let error = NSError.userError(with: "Ресторан не найден")
                    let response = RestaurantModels.ErrorModel.Response(error: error)
                    presenter?.presentError(response: response)
                } else {
                    let response = RestaurantModels.LoadRestaurant.Response(dto: dto[0])
                    presenter?.presentRestaurant(response: response)
                }
            } catch {
                let nsError = error as NSError
                let response = RestaurantModels.ErrorModel.Response(error: nsError)
                presenter?.presentError(response: response)
            }
        }
    }
}

