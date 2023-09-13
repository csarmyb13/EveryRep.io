//
//  ProfileSettingsView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/17/23.
//

import SwiftUI
import Firebase

struct ProfileSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var editedBio = ""
    
    // Logout action
    private func logout() {
        do {
            try Auth.auth().signOut() // Sign out the user from Firebase Authentication
            
            // Perform any additional logout-related operations
            
            // Redirect to the sign-in page (ContentView)
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = UIHostingController(rootView: LoginView())
            }
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }




    
    var body: some View {
        NavigationView { // Wrap the view in a NavigationView
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text("Profile Settings")
                            .padding()
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        
                        Spacer()
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Dismiss the ProfileSettingsView
                        }) {
                            Text("Done")
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        }
                    }
                    .padding()
                    .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                    
                    HStack {
                        TextField("Bio", text: $editedBio)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        
                        Button(action: {
                            saveBio()
                        }) {
                            Text("Save")
                        }
                        .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        .padding()
                        .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                        .cornerRadius(10)
                    }
                    .padding()
                    Spacer()
                    
                    // Logout button
                    Button(action: {
                        logout() // Call the logout action when the button is tapped
                    }) {
                        Text("Logout")
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                            .frame(width: 250, height: 50)
                            .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                            .cornerRadius(10)
                    }
                    .font(.headline)
                }
            }
            .background(Color(red: 204/255, green: 199/255, blue: 175/255))
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
    
    private func saveBio() {
        userSettings.bio = editedBio
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
            .environmentObject(UserSettings())
    }
}
