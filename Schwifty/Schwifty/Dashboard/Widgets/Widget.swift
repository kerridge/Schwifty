import SwiftUI

enum Widget {
    enum AvailableTypes: String {
        case latestMovies = "latest"
        case trendingMovies = "trending"
    }
    
    case latestMovies(LatestMoviesViewModel)
    case trendingMovies
}

extension Widget {
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .latestMovies(let vm):
            LatestMoviesView(viewModel: vm)
        case .trendingMovies:
            EmptyView()
        }
    }
}

extension Widget {
    func load() async {
        switch self {
        case .latestMovies(let viewModel):
            await viewModel.load()
        case .trendingMovies:
            print("load")
        }
    }
}

extension Widget: Identifiable {
    var id: String { rawValue }
    
    var rawValue: String {
        switch (self) {
        case .latestMovies(_):
            return Widget.AvailableTypes.latestMovies.rawValue
        case .trendingMovies:
            return Widget.AvailableTypes.trendingMovies.rawValue
        }
    }
}
