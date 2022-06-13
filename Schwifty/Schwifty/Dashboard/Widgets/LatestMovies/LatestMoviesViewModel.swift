import SwiftUI

struct LatestMoviesInputs {
    var title: String
    let service: LatestMoviesServiceable
}

final class LatestMoviesViewModel: WidgetViewModel, AsyncWidgetLoadable {
    typealias Dependencies = LatestMoviesInputs
    
    private let service: LatestMoviesServiceable
    
    @Published private(set) var state: WidgetLoadingState<LatestMovies> = .empty
    
    var title: String = "Latest Movies"
    
    private var latest: LatestMovies = .init(movies: [])
    
    init(dependencies: LatestMoviesInputs) {
        self.title = dependencies.title
        self.service = dependencies.service
    }
    
    @MainActor
    func load() async {
        self.state = .loading(placeholder: .placeholder)
        
        let oneSecond: UInt64 = 1_000_000_000
//        try! await Task.sleep(nanoseconds: oneSecond * 2)
        
        let result = await service.getLatest()
        
        switch result {
        case .success(let page):
            latest.movies = page.results.map { MovieListItem(movie: $0) }
            
        case .failure(let error):
            return self.state = .error(error)
        }
        
        return self.state = .loaded(content: latest)
    }
}
