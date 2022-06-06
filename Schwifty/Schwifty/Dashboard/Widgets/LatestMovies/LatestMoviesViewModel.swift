import SwiftUI

final class LatestMoviesViewModel: ObservableObject, AsyncWidgetLoadable {
    @Published private(set) var state: WidgetLoadingState<[LatestMovie]> = .empty
    
    @State private(set) var title: String = "Latest Movies"
    
    private var movies: [LatestMovie] = []
    
    @MainActor
    func load() async {
        self.state = .loading(placeholder: LatestMovie.placeholders)
        
        let oneSecond: UInt64 = 1_000_000_000
        try! await Task.sleep(nanoseconds: oneSecond * 5)
        
        movies = [
            LatestMovie(name: "movie 1"),
            LatestMovie(name: "movie 2")
        ]
        
        self.state = .loaded(content: movies)
    }
}
