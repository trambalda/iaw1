struct MenuDto: Decodable {
    let id: Int
    let name: String
    let dishesId: [Int]
}
