import SwiftUI

struct PageHeader<LeftAction: View, RightAction: View>: View {
    let title: String
    let leftAction: () -> LeftAction
    let rightAction: () -> RightAction
    
    init(
        title: String,
        @ViewBuilder leftAction: @escaping () -> LeftAction,
        @ViewBuilder rightAction: @escaping () -> RightAction
    ) {
        self.leftAction = leftAction
        self.rightAction = rightAction
        self.title = title
    }
    
    var body: some View {
        HStack(alignment: .center) {
            leftAction()
            
            Spacer()
            Text(title)
            Spacer()
            
            rightAction()
        }
    }
}

extension PageHeader where LeftAction == EmptyView, RightAction == EmptyView {
    init(title: String) {
        self.init(
            title: title,
            leftAction: { EmptyView() },
            rightAction: { EmptyView() }
        )
    }
}

extension PageHeader where LeftAction == EmptyView {
    init(
        title: String,
        @ViewBuilder rightAction: @escaping () -> RightAction
    ) {
        self.init(
            title: title,
            leftAction: { EmptyView() },
            rightAction: rightAction
        )
    }
}

extension PageHeader where RightAction == EmptyView {
    init(
        title: String,
        @ViewBuilder leftAction: @escaping () -> LeftAction
    ) {
        self.init(
            title: title,
            leftAction: leftAction,
            rightAction: { EmptyView() }
        )
    }
}
