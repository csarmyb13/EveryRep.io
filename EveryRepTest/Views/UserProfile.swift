//
//  UserProfile.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/11/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

struct BannerView: View {
    var body: some View {
        HStack {
            SearchButton()
            Spacer()
            ProfileSettingsButton()
        }
        .padding()
        .background(Color(red: 51/255, green: 102/255, blue: 102/255))
    }
}

struct SearchButton: View {
    var body: some View {
        Button(action: {
            // Action for search button
        }) {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct ProfileSettingsButton: View {
    var body: some View {
        Button(action: {
            // Action for profile settings button
        }) {
            Image(systemName: "person.circle")
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct UserProfilePicture: View {
    @State private var isPickerShowing = false
    @State private var selectedImage: UIImage?
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    var body: some View {
        HStack {
            Button(action: {
                // Action for selecting or changing a photo
                isPickerShowing = true
            }) {
                if let image = selectedImage {
                    // Display selected image
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    // Display default profile image
                    Image("Blank_Profile_Picture")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color(red: 51/255, green: 102/255, blue: 102/255), lineWidth: 5)
                        )
                }
            }
            .sheet(isPresented: $isPickerShowing) {
                // Image picker
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
            
            VStack {
                Text("Bio: John Doe, big lifter in a small town")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
    
    func uploadProfileImage() {
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        else {
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Specify the file path and name
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        // Upload the image data
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading profile image: \(error.localizedDescription)")
            } else {
                // Get the download URL
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else if let downloadURL = url {
                        // Save the download URL in Firestore
                        saveProfileImageURL(downloadURL)
                    }
                }
            }
        }
    }
    
    func saveProfileImageURL(_ downloadURL: URL) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData(["profileImageURL": downloadURL.absoluteString]) { error in
            if let error = error {
                print("Error saving profile image URL: \(error.localizedDescription)")
            } else {
                print("Profile image URL saved successfully.")
            }
        }
    }
}

struct UserProfile: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
                    .ignoresSafeArea()
                
                VStack {
                    BannerView()
                    
                    UserProfilePicture()
                    
                    Spacer()
                    
                    // Rest of your user profile content
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

