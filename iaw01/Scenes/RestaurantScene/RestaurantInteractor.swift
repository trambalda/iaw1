import UIKit

protocol RestaurantBusinessLogic {
    func loadRestaurant()
}

final class RestaurantInteractor: RestaurantBusinessLogic {
    
    var presenter: RestaurantPresentationLogic?
    var restaurantNetworkService: RestaurantNetworkService?     
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func loadRestaurant() {
        guard let restaurantNetworkService else { return }
        Task {
            do {
                let dto = try await restaurantNetworkService.fetchRestaurant(id: id)
                if dto.isEmpty {
                    let error = NSError(
                        domain: "com.foodDeliveryApp.restaurant",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "Ресторан не найден"]
                    )
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

