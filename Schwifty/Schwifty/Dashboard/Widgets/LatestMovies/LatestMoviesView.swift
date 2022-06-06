import SwiftUI

struct LatestMoviesView<ViewModel: LatestMoviesViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        WidgetCard(
            title: viewModel.title,
            rightAction: {
                Text("yo")
            }
        ) {
            WidgetLoadingView(
                loadingState: viewModel.state,
                content: { movies in
                    List {
                        ForEach(movies, id: \.name) { movie in
                            Text(movie.name)
                        }
                    }
                },
                emptyView: { EmptyView() },
                errorView: { _ in
                    EmptyView()
                }
            )
        }
//        .task {
//            viewModel.load()
//        }
    }
}
