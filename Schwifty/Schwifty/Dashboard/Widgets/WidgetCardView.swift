import SwiftUI

struct WidgetCard<Content: View, RightAction: View>: View {
    let title: String
    let rightAction: () -> RightAction
    let content: () -> Content
    
    init(
        title: String,
        @ViewBuilder rightAction: @escaping () -> RightAction,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.rightAction = rightAction
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(title)
                    .bold()
                
                Spacer()
                
                rightAction()
            }
                .padding([.top, .horizontal]) 
            
            content()
//                .padding()
        }
        .background(Color.white)
        .cornerRadius(12.0)
        .padding()
    }
}

extension WidgetCard where RightAction == EmptyView {
    init(title: String, content: @escaping () -> Content) {
        self.title = title
        self.rightAction = { EmptyView() }
        self.content = content
    }
}
