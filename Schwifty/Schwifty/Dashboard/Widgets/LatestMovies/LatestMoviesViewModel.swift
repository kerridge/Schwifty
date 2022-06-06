import SwiftUI

final class LatestMoviesViewModel: ObservableObject, AsyncWidgetLoadable {
    @Published private(set) var state: WidgetLoadingState<[MovieListItem]> = .empty
    
    @State private(set) var title: String = "Latest Movies"
    
    private var movies: [MovieListItem] = []
    
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
        self.state = .loading(placeholder: MovieListItem.placeholders)
        
        let oneSecond: UInt64 = 1_000_000_000
        try! await Task.sleep(nanoseconds: oneSecond * 5)
        
        let response = [
            LatestMovieDTO(name: "movie 1"),
            LatestMovieDTO(name: "movie 2")
        ]
        
        movies = response.map { MovieListItem(movie: $0) }
        
        self.state = .loaded(content: movies)
    }
}
