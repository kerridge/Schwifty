import SwiftUI

struct LatestMoviesInputs {
    var title: String
}

final class LatestMoviesViewModel: WidgetViewModel, AsyncWidgetLoadable {
    typealias Dependencies = LatestMoviesInputs
    
    @Published private(set) var state: WidgetLoadingState<LatestMovies> = .empty
    
    var title: String = "Latest Movies"
    
    private var latest: LatestMovies = .init(movies: [])
    
    init(dependencies: LatestMoviesInputs) {
        self.title = dependencies.title
    }
    
    struct LatestMovies {
        var movies: [MovieListItem]
        
        static let placeholder = LatestMovies(movies: MovieListItem.placeholders)
    }
    
    struct MovieListItem {
        let name: String
        
        init(movie: LatestMovieDTO) {
            name = movie.name
        }
        
        static let placeholders = LatestMovieDTO.placeholders.map {
            MovieListItem(movie: $0)
        }
    }
    
    @MainActor
    func load() async {
        self.state = .loading(placeholder: .placeholder)
        
        let oneSecond: UInt64 = 1_000_000_000
        try! await Task.sleep(nanoseconds: oneSecond * 8)
        
        let response = [
            LatestMovieDTO(name: "movie 1"),
            LatestMovieDTO(name: "movie 2")
        ]
        
        latest.movies = response.map { MovieListItem(movie: $0) }
        
        self.state = .loaded(content: latest)
    }
}
