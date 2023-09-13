//
//  EditProfileViewModel.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 9/12/23.
//

import Foundation
import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var profileImage: Image?
    
    private var uiImage : UIImage?
    
    init(user: User) {
        self.user = user
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage (data : data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await imageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        
    }
}
