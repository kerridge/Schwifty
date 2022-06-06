import SwiftUI

enum Widget {
    case latestMovies(viewModel: LatestMoviesViewModel)
}

extension Widget {
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .latestMovies(let vm):
            LatestMoviesView(viewModel: vm)
        }
    }
}

extension Widget: AsyncWidgetLoadable {
    func load() async {
        switch self {
        case .latestMovies(let viewModel):
            await viewModel.load()
        }
    }
}

extension Widget: Identifiable {
    var id: String { rawValue }
    
    var rawValue: String {
        switch (self) {
        case .latestMovies(_):
            return "latest movies"
        }
    }
}
