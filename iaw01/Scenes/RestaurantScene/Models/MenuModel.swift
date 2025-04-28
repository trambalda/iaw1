import Foundation

struct MenuModel {
    
    let id: Int
    let name: String
    let dishesId: [Int]
    
    static let empty = MenuModel(id: 0, name: "", dishesId: [])
}


extension MenuDto {
    
    func toModel() -> MenuModel {
        return MenuModel(
            id: id,
            name: name,
            dishesId: dishesId
        )
    }
}
