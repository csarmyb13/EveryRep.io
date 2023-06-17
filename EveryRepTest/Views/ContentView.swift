//
//  ContentView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/10/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                Rectangle()
                    .scale(0.9)
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                
                VStack {
                    Image("Logo01")
                        .resizable() // Make the image resizable
                        .frame(width: 354, height: 260) // Set the desired frame size for the image
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
                    
                    
                    NavigationLink(destination: UserProfile(), isActive: $showingLoginScreen) { // Use UserProfile() as the destination
                        EmptyView()
                    }
                    NavigationLink(destination: SignupView()) {
                        HStack {
                            Text("New User?")
                                .font(.system(size: 15))
                            Text("Sign Up")
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 51/255, green: 102/255, blue: 102/255))
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String, password: String) {
        let db = Firestore.firestore()
        db.collection("Users").whereField("username", isEqualTo: username).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("User not found")
                return
            }
            
            for document in documents {
                let userData = document.data()
                let storedUsername = userData["username"] as? String ?? ""
                let storedPassword = userData["password"] as? String ?? ""
                
                if storedUsername == username {
                    wrongUsername = 0
                    
                    if storedPassword == password {
                        wrongPassword = 0
                        showingLoginScreen = true
                        return
                    } else {
                        wrongPassword = 2
                        return
                    }
                }
            }
            
            wrongUsername = 2
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
