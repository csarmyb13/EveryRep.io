import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings // Access the userSettings
    
    var body: some View {
        if let storedToken = TokenManager.shared.getToken() {
            // A valid token exists, indicating the user is logged in.
            // You can display the user profile content.
            UserProfileContent()
        } else {
            // No valid token, user needs to log in.
            LoginView()
        }
    }
}
