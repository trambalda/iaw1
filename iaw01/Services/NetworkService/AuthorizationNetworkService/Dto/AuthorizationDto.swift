struct AuthorizationDto: Decodable {
    let userId: String
    let token: String
    let phone: String
}
