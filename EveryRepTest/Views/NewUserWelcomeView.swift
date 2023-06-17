//
//  NewUserWelcomeView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/12/23.
//

import SwiftUI

struct NewUserWelcomeView: View {
    @State private var showingUserProfile = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
            
                Image("Logo_Skeleton")
                Spacer()
                Button(action: {
                    showingUserProfile = true
                }) {
                    Text("Welcome!")
                        .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        .frame(width: 300, height: 50)
                        .background(Color(red: 51/255, green: 102/255, blue: 102/255))
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
                
                NavigationLink(destination: UserProfile(), isActive: $showingUserProfile) {
                    EmptyView()
                }
            }
        }
    }
}

struct NewUserWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserWelcomeView()
    }
}

