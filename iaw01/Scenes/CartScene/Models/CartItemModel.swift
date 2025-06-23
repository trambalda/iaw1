struct CartItemModel {
    let id: Int
    let image: String
    let restaurantName: String
    let itemName: String
    let price: Double
    let weight: Int
    let quantity: Int
    
    init(id: Int, image: String, restaurantName: String, itemName: String, price: Double, weight: Int, quantity: Int) {
        self.id = id
        self.image = image
        self.restaurantName = restaurantName
        self.itemName = itemName
        self.price = price
        self.weight = weight
        self.quantity = quantity
    }
}

extension CartItemModel {
    static let examples: [CartItemModel] = [
        CartItemModel(
            id: 0,
            image: "burger",
            restaurantName: "Pizza House",
            itemName: "Burger",
            price: 12.5,
            weight: 450,
            quantity: 1
        ),
        CartItemModel(
            id: 1,
            image: "burger",
            restaurantName: "Burger King",
            itemName: "Double Cheese",
            price: 9.0,
            weight: 300,
            quantity: 2
        )
    ]
}
