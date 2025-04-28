import Foundation

struct MenuItemListDto: Decodable {
    
    let id: Int
    let image: String
    let name: String
    let price: Float
    let weight: Int
}
