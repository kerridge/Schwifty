import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    @Published var title: String = "Movies!"
    
    @Published var widgets: [Widget] = []
    
    let widgetStore: WidgetStore
    
    // exhaustive list of available widgets
    lazy var allWidgets: [Widget] = [
        .latestMovies(latestMoviesVM),
        .trendingMovies
    ]
    
    lazy var latestMoviesVM = LatestMoviesViewModel(dependencies: .init(title: "Latest Movies"))
    
    init(widgetStore: WidgetStore) {
        self.widgetStore = widgetStore
        
        self.getSelectedWidgets()
        
        // If user has no selected widgets, show all
        if self.widgets.isEmpty {
            self.widgets = self.allWidgets
        }
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
    
    private func getSelectedWidgets() {
        let selectedWidgets = widgetStore.fetch()
        
        self.widgets = WidgetStore.mapToWidgets(
            selected: selectedWidgets,
            available: allWidgets
        )
    }
    
    private func cacheSelectedWidgets() {
        widgetStore.save(self.allWidgets)
    }
}
