import Foundation

protocol WidgetStore {
    var selected: [Widget] { get }
    var available: [Widget] { get }
    
    func updateSelected(_ widgets: [Widget])
    func updateAvailable(_ widgets: [Widget])
}

class OnDiskWidgetStore: WidgetStore {
    private enum Constants {
        static let key = "selected_widgets"
    }
    
    let defaults: UserDefaults!
    var available: [Widget] = []
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    var selected: [Widget] {
        return _selected
    }
    
    private var _selected: [Widget] {
        get {
            return self.fetch()
        }
        
        set {
            save(newValue)
        }
    }
    
    func updateSelected(_ widgets: [Widget]) {
        self._selected = widgets
    }
    
    func updateAvailable(_ widgets: [Widget]) {
        self.available = widgets
    }
    
    private func save(_ widgets: [Widget]) {
        defaults.set(
            widgets.map { $0.rawValue },
            forKey: Constants.key
        )
    }
    
    private func fetch() -> [Widget] {
        let widgetKeys = defaults.object(forKey: Constants.key) as? [String] ?? []
        
        let selectedWidgets = mapToWidgets(widgetKeys)
        
        // return all available widgets if none in cache
        if selectedWidgets.isEmpty {
            return self.available
        }
        
        return selectedWidgets
    }
    
    /// Maps strings from UserDefaults to a list of assembled `Widget`s
    private func mapToWidgets(_ selected: [String]) -> [Widget] {
        return selected.compactMap { widget in
            available.first(where: {
                $0.rawValue == widget
            })
        }
    }
}
