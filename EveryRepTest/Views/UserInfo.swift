//
//  UserInfo.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 7/2/23.
//
import SwiftUI

struct UserInfo: View {
    @State private var name = ""
    @State private var lastName = ""
    @State private var sport = ""
    @State private var isShowingNewUserWelcome = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) { // Set alignment to center
                    Image("smallLogo")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(.horizontal, 50)
                    
                    Text("Tell us a bit more about you!")
                        .padding(.horizontal, 80)
                    
                    TextField("First Name", text: $name)
                        .padding()
                        .frame(width: 350, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .frame(width: 350, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    TextField("Sport", text: $sport)
                        .padding()
                        .frame(width: 350, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: NewUserWelcomeView(),
                        isActive: $isShowingNewUserWelcome) {
                        Button(action: {
                            // Action to perform when the button is tapped
                            isShowingNewUserWelcome = true
                        }) {
                            Text("Continue")
                                .font(.headline)
                                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                                .padding()
                                .frame(width: 200)
                                .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 50) // Adjust the top padding value to push the content down
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
    }
}
