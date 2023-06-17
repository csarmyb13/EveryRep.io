//
//  WelcomeScreenView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/10/23.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Rectangle()
                .scale(0.9)
                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
            
            VStack {
                Image("Logo")
                    .resizable() // Make the image resizable
                    .frame(width: 354, height: 300) // Set the desired frame size for the image
                    .padding(.top) // Pushes the image to the top edge
                
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.red, width: CGFloat(wrongUsername))
                
                SecureField("Password", text: $password) // Use SecureField for password input
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(Color.red, width: CGFloat(wrongPassword))
                
                Button("Login") {
                    authenticateUser(username: username, password: password) // Fixed typo in function name
                }
                
                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                .frame(width: 300, height: 50)
                .background(Color(red: 51/255, green: 102/255, blue: 102/255))
                .cornerRadius(10)
                
                NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen){
                    EmptyView()
                }
                HStack {
                    Text("New User?")
                        .font(.system(size: 15))
                    Text("Sign Up")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 51/255, green: 102/255, blue: 102/255))
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
