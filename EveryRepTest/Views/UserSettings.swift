import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var bio = ""
    @Published var isUserLoggedIn = false
}
