import Foundation
import SwiftUI
 
final class DashboardViewModel: ObservableObject {
    @Published var title: String = "Movies!"
    
    @Published var widgets: [Widget] = []
    
    let widgetStore: WidgetStore
    
    // exhaustive list of available assembled widgets
    lazy var allWidgets: [Widget] = [
        .latestMovies(latestMoviesVM),
        .trendingMovies
    ]
    
    lazy var latestMoviesVM = LatestMoviesViewModel(
        dependencies: .init(
            title: "Latest Movies",
            service: LatestMoviesService()))
    
    init(widgetStore: WidgetStore) {
        self.widgetStore = widgetStore
        self.widgetStore.updateAvailable(allWidgets)
        
        // present the users selected widgets
        self.widgets = widgetStore.selected
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
    
    private func updateSelectedWidgets() {
        widgetStore.updateSelected(widgets)
    }
}
