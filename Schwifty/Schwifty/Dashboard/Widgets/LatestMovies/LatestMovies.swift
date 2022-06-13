struct LatestMovies {
    var movies: [MovieListItem]
    
    static let placeholder = LatestMovies(movies: MovieListItem.placeholders)
}

struct MovieListItem: Identifiable {
    let id: Int
    let title: String
    
    init(movie: MovieDTO) {
        id = movie.id
        title = movie.title
    }
    
    static let placeholders = MovieDTO.placeholders.map {
        MovieListItem(movie: $0)
    }
}
