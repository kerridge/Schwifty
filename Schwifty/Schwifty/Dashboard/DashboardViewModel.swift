import Foundation
import SwiftUI

@MainActor final class DashboardViewModel: ObservableObject {
    @Published var title: String
    
    @Published var widgets: [Widget]
    
    var latestMoviesVM = LatestMoviesViewModel()
    
    init(title: String) {
        self.title = title
        
        // widgets we want to display
        self.widgets = [
            .latestMovies(viewModel: latestMoviesVM)
        ]
    }
    
    func loadWidgets() async {
        await withTaskGroup(of: Void.self) { group in
            for widget in self.widgets {
                group.addTask {
                    await widget.load()
                }
            }
        }
    }
}
