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
                content: { latest in
                    List {
                        ForEach(latest.movies, id: \.name) { movie in
                            Text(movie.name)
                        }
                    }
                },
                empty: { EmptyView() },
                error: { _ in
                    EmptyView()
                }
            )
        }
    }
}
