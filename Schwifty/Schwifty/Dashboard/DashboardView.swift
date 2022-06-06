import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            PageHeader(title: viewModel.title)
            
            Spacer()
            
            ForEach(viewModel.widgets) { widget in
                widget.view()
                    .task {
                        await viewModel.loadWidgets()
                    }
            }
            
            Spacer()
        }
        .background(Color.gray)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DashboardViewModel(title: "fuck")
        
        DashboardView(viewModel: vm)
    }
}
