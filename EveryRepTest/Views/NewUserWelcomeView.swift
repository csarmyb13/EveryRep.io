//
//  NewUserWelcomeView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/12/23.
//

import SwiftUI

struct NewUserWelcomeView: View {
    @State private var isShowingUserProfile = false
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Time To Grind!")
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    .font(.system(size: 50))
                Image("Logo_Skeleton")
                Text("Are you ready?")
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    .font(.system(size: 50))
                
                Spacer()
                
                NavigationLink(
                    destination: UserProfileContent(),
                    isActive: $isShowingUserProfile) {
                        Button(action: {
                            isShowingUserProfile = true
                        }) {
                            Text("Welcome!")
                                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                                .frame(width: 300, height: 50)
                                .background(Color(red: 51/255, green: 102/255, blue: 102/255))
                                .cornerRadius(10)
                        }
                    }
                }
                
                .padding()
                Spacer()
                
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NewUserWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserWelcomeView()
    }
}
