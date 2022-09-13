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
                        ForEach(latest.movies) { movie in
                            Text(movie.title)
                        }
                    }
                },
                empty: { EmptyView() },
                error: { _ in
                    EmptyView()
                }
            )
        }
        .frame(height: 400)
    }
}
