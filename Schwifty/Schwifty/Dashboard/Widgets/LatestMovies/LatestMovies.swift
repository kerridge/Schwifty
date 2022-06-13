struct LatestMovies {
    var movies: [MovieListItem]
    
    static let placeholder = LatestMovies(movies: MovieListItem.placeholders)
}

struct MovieListItem: Identifiable {
    let id: Int
    let title: String
    
    init(movie: ListMovieDTO) {
        id = movie.id
        title = movie.title
    }
    
    static let placeholders = ListMovieDTO.placeholders.map {
        MovieListItem(movie: $0)
    }
}
