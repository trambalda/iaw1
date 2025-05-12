import Foundation

struct MenuItemListModel {
    
    let id: Int
    let imageURL: URL?
    let name: String
    let price: Float
    let weight: Int
    
    static let empty = MenuItemListModel(
        id: 0,
        imageURL: nil,
        name: "",
        price: 0.0,
        weight: 0
    )
}

extension MenuItemListDto {
    
    var model: MenuItemListModel {
        MenuItemListModel(
            id: id,
            imageURL: URL(string: image),
            name: name,
            price: price,
            weight: weight
        )
    }
}
