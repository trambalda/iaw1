import UIKit

struct MenuModel: Codable {
    
    let id: Int
    let name: String
    let dishesId: [Int]
    
    static let empty = MenuModel(id: 0, name: "", dishesId: [])
}
