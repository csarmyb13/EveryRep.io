import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 35) {
                    ForEach(0 ... 10, id: \.self) { post in
                        FeedCell()
                    }
                }
                .padding(.top, 8)
            }
            .background(Color(red: 204/255, green: 199/255, blue: 175/255)) // Change the color here
            .navigationBarTitle("News Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("Modern")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer()
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
