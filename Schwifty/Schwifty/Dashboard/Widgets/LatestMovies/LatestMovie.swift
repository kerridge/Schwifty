struct LatestMovie {
    var name: String
    
    static let placeholders: [Self] = (0..<10).map { _ in
        let length = Int.random(in: 8..<30)
        
        return LatestMovie(name: String.random(length: length))
    }
}

//extension LatestMovie: Identifiable {
//    var id: String {
//        self.name
//    }
//}
