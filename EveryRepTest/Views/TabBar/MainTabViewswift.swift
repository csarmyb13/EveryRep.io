//
//  MainTabViewswift.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 9/12/23.
//

import SwiftUI

struct MainTabViewswift: View {
    var body: some View {
        ZStack {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("Upload Post")
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                Text("Notification")
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                UserProfileContent()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .accentColor(Color(red: 204/255, green: 199/255, blue: 175/255))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MainTabViewswift_Previews: PreviewProvider {
    static var previews: some View {
        MainTabViewswift()
    }
}
