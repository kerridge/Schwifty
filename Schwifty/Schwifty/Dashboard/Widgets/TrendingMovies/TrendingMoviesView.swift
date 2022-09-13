import SwiftUI

struct TrendingMoviesView: View {
    
    var body: some View {
        WidgetCard(
            title: "Trending Movies",
            rightAction: {
                Text("ya")
            }
        ) {
            VStack(alignment: .center, spacing: 50){
                HStack {
                    Spacer()
                    
                    Text("Hello")
                        .font(.largeTitle)
                    
                    Spacer()
                }
                
                Button(action: {  }) {
                    Text("Click me")
                }
            }
                .padding()
                .frame(height: 200)
        }
    }
}
