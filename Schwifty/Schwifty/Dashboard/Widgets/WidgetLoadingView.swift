import SwiftUI

struct WidgetLoadingView
<
    Item,
    Content: View,
    EmptyView: View,
    ErrorView: View
>: View {
    
    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))

    private let state: WidgetLoadingState<Item>
    private let makeContent: (Item) -> Content
    private let makeEmpty: () -> EmptyView
    private let makeError: (Error) -> ErrorView
    
    init(
        loadingState: WidgetLoadingState<Item>,
        @ViewBuilder content: @escaping (Item) -> Content,
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
                .redacted(reason: .placeholder)
                .transition(fade)
            
        case let .loaded(content):
            makeContent(content)
                .transition(fade)

        case .empty:
            makeEmpty()
                .transition(fade)

        case let .error(error):
            makeError(error)
                .transition(fade)

        }
    }
}
