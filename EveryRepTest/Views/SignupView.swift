//
//  SignupView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/11/23.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var secondPassword = ""
    @State private var isUsernameTaken = false
    @State private var isEmailTaken = false
    @State private var showingWelcomeView = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                .ignoresSafeArea()
            
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    Image("Apple")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Sign up with Apple")
                        .font(.title2)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                
                HStack {
                    Image("Google")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Sign up with Google")
                        .font(.title2)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                
                HStack {
                    Image("Facebook")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Sign up with Facebook")
                        .font(.title2)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .background(Color.white)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                
                Text("Or")
                    .font(.system(size: 20))
                
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(isEmailTaken ? Color.red : Color.gray, width: 1)
                        .overlay(
                            VStack {
                                if isEmailTaken {
                                    Text("Already taken")
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, -10)
                                        
                                }
                            }
                        )
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(isUsernameTaken ? Color.red : Color.gray, width: 1)
                        .overlay(
                            VStack {
                                if isUsernameTaken {
                                    Text("Already taken")
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 10)
                                    
                                }
                                Spacer()
                            }
                        )
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $secondPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        createUser()
                        checkUsernameAvailability() // Call checkUsernameAvailability here
                        checkEmailAvailability()
                    }) {
                        Text("Create Account")
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                            .padding()
                            .background(Color(red: 51/255, green: 102/255, blue: 102/255))
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                NavigationLink(
                    destination: NewUserWelcomeView(),
                    isActive: $showingWelcomeView,
                    label: {
                        EmptyView()
                    })
            }
        }
    }
    func checkEmailAvailability() {
        let db = Firestore.firestore()
        db.collection("Users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking email availability: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                // Email is available, proceed with creating the account
                createUser()
                return
            }
            
            if documents.isEmpty {
                // Email is available, proceed with creating the account
                createUser()
            } else {
                isEmailTaken = true
                print("Email is already in use")
            }
        }
    }
    func checkUsernameAvailability() {
        let db = Firestore.firestore()
        db.collection("Users").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking username availability: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                // Username is available, proceed with creating the account
                isUsernameTaken = false
                return
            }
            
            if documents.isEmpty {
                // Username is available, proceed with creating the account
                isUsernameTaken = false
            } else {
                isUsernameTaken = true
                print("Username is already in use")
            }
        }
    }
    func createUser() {
        if !isUsernameTaken && !isEmailTaken {
            if email != "" && username != "" && password != "" && secondPassword != "" {
                if password == secondPassword {
                    if password.count >= 6 { // Check if the password has at least 6 characters
                        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
                            if let err = err {
                                print(err)
                                return
                            }
                            // Account creation successful
                            createUserInfo()
                            showingWelcomeView = true
                        }
                    } else {
                        print("Password should have at least 6 characters")
                    }
                } else {
                    print("Passwords do not match")
                }
            } else {
                print("Please fill in all fields")
            }
        }
        
        
        func createUserInfo() {
            if let user = Auth.auth().currentUser {
                let db = Firestore.firestore()
                let userID = user.uid
                db.collection("Users").document("\(userID)").setData(["email": email, "username": username, "password": password, userID: userID]) { error in
                    if let error = error {
                        print("Error creating user info: \(error)")
                    } else {
                        // User info creation successful
                        // Proceed to next screen or perform desired action
                    }
                }
            }
        }
    }
    
    struct SignupView_Previews: PreviewProvider {
        static var previews: some View {
            SignupView()
        }
    }
}
