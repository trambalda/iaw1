import UIKit

protocol RestaurantPresentationLogic {
    func presentRestaurant(response: RestaurantModels.LoadRestaurant.Response)
    func presentError(response: RestaurantModels.ErrorModel.Response)
}

final class RestaurantPresenter: RestaurantPresentationLogic {
    
    weak var viewController: RestaurantDisplayLogic?
    
    func presentRestaurant(response: RestaurantModels.LoadRestaurant.Response) {
        let viewModel = RestaurantModels.LoadRestaurant.ViewModel(model: response.dto.model)
        DispatchQueue.main.async {
            self.viewController?.displayRestaurant(viewModel: viewModel)
        }
    }
    
    func presentError(response: RestaurantModels.ErrorModel.Response) {
        let viewModel = RestaurantModels.ErrorModel.ViewModel(errorDescription: response.error.localizedDescription)
        DispatchQueue.main.async {
            self.viewController?.displayError(viewModel: viewModel)
        }
    }
}
