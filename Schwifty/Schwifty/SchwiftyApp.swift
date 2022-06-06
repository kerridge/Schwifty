import SwiftUI

@main
struct SchwiftyApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView(
                viewModel: DashboardViewModel(
                    title: "Movies!")
            )
        }
    }
}
