import SwiftUI

struct LatestMoviesView: View {
    @ObservedObject var viewModel: LatestMoviesViewModel
    
    var body: some View {
        WidgetCard(
            title: viewModel.title,
            rightAction: { Text("yo") }
        ) {
            Group {
                switch (viewModel.state) {
                case .empty:
                    EmptyView()
                    
                case .loading(let shimmer):
                    EmptyView()
                    
                case .loaded(let movies):
                    List {
                        ForEach(movies, id: \.name) { movie in
                            Text(movie.name)
                        }
                    }
                case .error(_):
                    EmptyView()
                }
            }
        }
//        .task {
//            viewModel.load()
//        }
    }
}
