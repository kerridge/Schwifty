import SwiftUI

protocol AsyncWidgetLoadable {
    associatedtype T
    var state: WidgetLoadingState<T> { get }
    
    func load() async
}
