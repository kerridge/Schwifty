import SwiftUI

protocol WidgetViewModel: ObservableObject {
    associatedtype Dependencies
    
    var title: String { get }
    
    init(dependencies: Dependencies)
}
