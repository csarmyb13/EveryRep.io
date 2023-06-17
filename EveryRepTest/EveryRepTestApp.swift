//
//  EveryRepTestApp.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 6/10/23.
//

import SwiftUI
import Firebase

@main
struct YourAppNameApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

