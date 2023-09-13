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
import MobileCoreServices
//import AVKit0

struct BannerView: View {
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        
        //Header
            HStack {
                SearchButton()
                Spacer()
                ProfileSettingsButton()
            }
            .padding()
            .background(Color(red: 42/255, green: 58/255, blue: 47/255))
        }
    }


    struct SearchButton: View {
        var body: some View {
            Button(action: {
                // Action for search button
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
            }
        }
    }

    struct ProfileSettingsButton: View {
        @State private var isEditProfileViewActive = false

        var body: some View {
            Button(action: {
                isEditProfileViewActive = true
            }) {
                Image(systemName: "person.circle")
                    .font(.title)
                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 175/255))
            }
            .fullScreenCover(isPresented: $isEditProfileViewActive) {
                EditProfileView(user: User.MOCK_USERS[0])
                    .transition(.move(edge: .bottom)) // Apply slide-up transition
            }
        }
    }

    struct UserProfilePicture: View {
        @State private var isPickerShowing = false
        @State private var selectedImage: UIImage?
        
        // Firebase Firestore reference
        let db = Firestore.firestore()
        let storage = Storage.storage()
        let user = Auth.auth().currentUser
        
        @State private var profilePictureURL: String?
        
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
                                Circle().stroke(Color(red: 42/255, green: 58/255, blue: 47/255), lineWidth: 5)
                            )
                    }
                }
                .sheet(isPresented: $isPickerShowing) {
                    // Image picker
                    ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                }
                Spacer()
                
                VStack {
                    Text("Bio: \(UserSettings().bio)") // Access the bio property through the UserSettings instance
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 200, height: 100)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
    }


    struct UserProfileContent: View {
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
                        
                        
                    }
                    .padding(.top)
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true) // Hide the back button
            }
            .navigationBarBackButtonHidden(true) // Additional line to hide the back button
        }
    }

    struct UserProfile_Previews: PreviewProvider {
        static var previews: some View {
            UserProfileContent()
                .environmentObject(UserSettings())
        }
    }
