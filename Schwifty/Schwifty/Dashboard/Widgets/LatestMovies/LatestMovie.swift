struct LatestMovieDTO: Codable {
    var name: String
    
    static let placeholders: [Self] = (0..<10).map { _ in
        let length = Int.random(in: 8..<30)
        
        return LatestMovieDTO(name: String.random(length: length))
    }
}

struct LatestMovies: Codable {
    var movies: [LatestMovieDTO]
}

//extension LatestMovie: Identifiable {
//    var id: String {
//        self.name
//    }
//}
