import SwiftUI
import UniformTypeIdentifiers

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    @State var draggedWidget: Widget?
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                PageHeader(title: viewModel.title)
                
                ForEach(viewModel.widgets) { widget in
                    widget.view()
                        .onDrag({
                            self.draggedWidget = widget
                            return NSItemProvider(object: widget.id as NSString)
                        })
                        .onDrop(
                            of: [UTType.text],
                            delegate: WidgetDropDelegate(
                                widgets: $viewModel.widgets,
                                draggedWidget: $draggedWidget,
                                listWidget: widget
                            )
                        )

                }
            }
        }
        .background(Color.gray)
        .task {
            await viewModel.loadWidgets()
        }
    }
}


struct WidgetDropDelegate: DropDelegate {
    @Binding var widgets: [Widget]
    @Binding var draggedWidget: Widget?
    
    var listWidget: Widget
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggedWidget = self.draggedWidget else {
            return
        }
        
        if draggedWidget.id != listWidget.id {
            
            let from = widgets.firstIndex(where: {
                $0.id == draggedWidget.id
                
            })!
            
            let to = widgets.firstIndex(where: {
                $0.id == listWidget.id
            })!
            
            withAnimation(.default) {
                self.widgets.move(
                    fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to
                )
            }
        }
    }
}
