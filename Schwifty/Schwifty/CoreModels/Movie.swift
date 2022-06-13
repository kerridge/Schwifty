struct MovieDTO: Codable, Identifiable {
    var id: Int
    var title: String
    var original_title: String
    var genre_ids: [Int]
    var release_date: String
    var overview: String
    var poster_path: String
    
    static let placeholders: [Self] = (0..<10).map { i in
        let length = Int.random(in: 8..<30)
        
        return MovieDTO(
            id: i,
            title: String.random(length: length),
            original_title: "",
            genre_ids: [],
            release_date: "",
            overview: "",
            poster_path: ""
        )
    }
    
    init(
        id: Int,
        title: String,
        original_title: String,
        genre_ids: [Int],
        release_date: String,
        overview: String,
        poster_path: String
    ) {
        self.id = id
        self.title = title
        self.original_title = original_title
        self.genre_ids = genre_ids
        self.release_date = release_date
        self.overview = overview
        self.poster_path = poster_path
    }
}
