import Foundation

class WidgetStore {
    private let key = "selected_widgets"
    let defaults: UserDefaults!
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    func save(_ widgets: [Widget]) {
        defaults.set(
            widgets.map { $0.rawValue },
            forKey: key
        )
    }
    
    func fetch() -> [String] {
        return defaults.object(forKey: key) as? [String] ?? [String]()
    }
    
    /// Maps strings from UserDefaults to a list of assembled `Widget`s
    static func mapToWidgets(selected: [String], available: [Widget]) -> [Widget] {
        return selected.compactMap { widget in
            available.first(where: {
                $0.rawValue == widget
            })
        }
    }
}
