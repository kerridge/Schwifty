import SwiftUI

@MainActor final class LatestMoviesViewModel: ObservableObject, AsyncWidgetLoadable {
    
    @Published var state: WidgetLoadingState<[LatestMovie]> = .empty
    
    @Published var title: String = "Latest Movies"
    
    var movies: [LatestMovie] = []
    
    func load() async {
        self.state = .loading(placeholder: [])
        
        movies = [
            LatestMovie(name: "movie 1"),
            LatestMovie(name: "movie 2")
        ]
        
        self.state = .loaded(content: movies)
    }
}
