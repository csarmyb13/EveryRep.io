//
//  LoginView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/21/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .top) {
                Color(red: 204/255, green: 199/255, blue: 175/255) // Set the desired background color
                    .ignoresSafeArea() // Ignore safe areas
                ScrollView{
                    VStack {
                        
                        Image("Modern")
                            .resizable() // Make the image resizable
                            .frame(width: 400, height: 400) // Set the desired frame size for the image
                            .padding(.top) // Pushes the image to the top edge
                            .padding(.bottom, -20)
                        
                        //                    Text("Welcome!")
                        //                        .font(.largeTitle)
                        //                        .bold()
                        //                        .padding()
                        
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
                        
                        Button(action: {
                            authenticateUser(username: username, password: password)
                        }) {
                            Text("Login")
                                .foregroundColor(Color(.white))
                                .frame(width: 300, height: 50)
                        }
                        .background(
                            Rectangle()
                                .fill(Color(red: 42/255, green: 58/255, blue: 47/255))
                                .cornerRadius(10)
                        )
                        
                        
                        NavigationLink(destination: MainTabViewswift(), isActive: $showingLoginScreen) { // Use UserProfile() as the destination
                            EmptyView()
                        }
                        NavigationLink(destination: SignupView()) {
                            HStack {
                                Text("New User?")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                Text("Sign Up")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(red: 51/255, green: 102/255, blue: 102/255))
                            }
                            
                        }
                        .padding()
                        Spacer()
                    }
                    
                    .navigationBarBackButtonHidden(true)
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                }
                .navigationBarHidden(true)
                
            }
            .navigationBarBackButtonHidden(true)
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

                        // Successfully authenticated the user, save the token
                        if let user = Auth.auth().currentUser {
                            user.getIDToken { (token, error) in
                                if let error = error {
                                    print("Error getting ID token: \(error.localizedDescription)")
                                    return
                                }
                                
                                if let userToken = token {
                                    TokenManager.shared.saveToken(userToken)
                                }
                            }
                        }
                        
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
    

    struct UserProfile: View {
        @Environment(\.presentationMode) var presentationMode
        @EnvironmentObject var userSettings: UserSettings
        
        var body: some View {
            NavigationView {
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        .ignoresSafeArea()
                    
                    VStack {
                        BannerView(user: User.MOCK_USERS[0])
                        
                        UserProfilePicture()
                        
                        Spacer()
                        
                        // Rest of your user profile content
                    }
                    .padding(.top)
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true) // Hide the back button
            }
            .navigationBarBackButtonHidden(true) // Additional line to hide the back button
            
        }
    }
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
