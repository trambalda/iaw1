import UIKit

struct MenuModel: Codable {
    
    let id: Int
    let name: String
    let dishesID: [Int]
    
    enum CodingKeys: String, CodingKey {
        case dishesID = "dishesId"
        case id, name
    }
    
    static let empty = MenuModel(id: 0, name: "", dishesID: [])
}
