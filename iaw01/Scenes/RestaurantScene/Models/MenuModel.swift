import UIKit

struct MenuModel: Codable {
    
    let id: Int
    let name: String
    
    static let empty = MenuModel(id: 0, name: "")
}

extension MenuModel {
    
    static let mock : [MenuModel] = [
        MenuModel(id: 1, name: "Breakfast Menu"),
        MenuModel(id: 2, name: "Lunch & Dinner"),
        MenuModel(id: 3, name: "Overnight Menu")
    ]
}
