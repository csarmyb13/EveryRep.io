//
//  EveryRepTestApp.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/10/23.
//

import SwiftUI
import Firebase

@main
struct EverRepTest: App {
    @StateObject private var userSettings = UserSettings()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if let storedToken = TokenManager.shared.getToken() {
                // A valid token exists, so the user is already authenticated.
                // You can consider automatically navigating to a protected part of your app.
                // For example, if there's a DashboardView, you can do:
                UserProfileContent()
                    .environmentObject(userSettings)
            } else {
                // No stored token, user needs to log in.
                // Show the login view.
                LoginView()
                    .environmentObject(userSettings)
            }
        }
    }
    
}


