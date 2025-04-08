extension Optional where Wrapped == String {
    var notNilNotEmpty: Bool {
        self?.isEmpty == false
    }
}
