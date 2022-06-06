public extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = Int.random(in: 8..<base.count)
            randomString += "\(base[base.index(base.startIndex, offsetBy: randomValue)])"
        }
        return randomString
    }
}
