import SwiftUI

struct WidgetLoadingView
<
    Item,
    Content: View,
    EmptyView: View,
    ErrorView: View
>: View {
    
    private let state: WidgetLoadingState<[Item]>
    private let makeContent: ([Item]) -> Content
    private let makeEmpty: () -> EmptyView
    private let makeError: (Error) -> ErrorView
    
    init(
        loadingState: WidgetLoadingState<[Item]>,
        @ViewBuilder content: @escaping ([Item]) -> Content,
        @ViewBuilder emptyView: @escaping () -> EmptyView,
        @ViewBuilder errorView: @escaping (Error) -> ErrorView
    ) {
        state = loadingState
        makeContent = content
        makeEmpty = emptyView
        makeError = errorView
    }
    
    var body: some View {
        switch state {
        case let .loading(placeholders):
            makeContent(placeholders)
        case let .loaded(content):
            makeContent(content)
        case .empty:
            makeEmpty()
        case let .error(error):
            makeError(error)
        }
    }
}
