import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    @Published var title: String = "Movies!"
    
    @Published var widgets: [Widget] = []
    
    // exhaustive list of available widgets
    lazy var allWidgets: [Widget] = [
        .latestMovies(latestMoviesVM),
        .trendingMovies
    ]
    
    // will probably come from user defaults
    let selectedWidgets: [String] = [
        "latest",
        "trending"
    ]
    
    lazy var latestMoviesVM = LatestMoviesViewModel(dependencies: .init(title: "Latest Movies"))
    
    init() {
        self.widgets = mapToWidgetList(selectedWidgets)
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
    
    /// Maps strings from UserDefaults to a list of assembled `Widget`s
    func mapToWidgetList(_ selectedWidgets: [String]) -> [Widget] {
        return selectedWidgets.compactMap { selectedWidget in
            self.allWidgets.first(where: {
                $0.rawValue == selectedWidget
            })
        }
    }
}
