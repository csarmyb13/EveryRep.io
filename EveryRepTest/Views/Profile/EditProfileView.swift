//
//  EditProfileView.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 9/12/23.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import Firebase
import FirebaseStorage

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: PhotosPickerItem?
    @StateObject var viewModel: EditProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettings: UserSettings
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            // Toolbar
            VStack {
                HStack{
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    
                    Spacer()
                    
                    Button {
                        print("Update profile picture")
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                        
                    }
                    
                }
                .padding()
                .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                
                Divider()
            }
            
            //edit Profile Pic
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                    else{
                        Image("Blank_Profile_Picture")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    }
                    
                    Text("Edit Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 42/255, green: 58/255, blue: 47/255))
                    
                    Divider()
                }
            }
            .padding(.vertical, 10)
            
            //edit profile info
            
            Spacer()
            Button(action: {
                        logout() // Call the logout action when the button is tapped
                    }) {
                        Text("Logout")
                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                            .frame(width: 250, height: 50)
                            .background(Color(red: 42/255, green: 58/255, blue: 47/255))
                            .cornerRadius(10)
                    }
        }
        .background(Color(red: 204/255, green: 199/255, blue: 175/255))
        
    }
    
}
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

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
