import Foundation
import CryptoKit

class TokenManager {
    static let shared = TokenManager()
    private let userDefaults = UserDefaults.standard
    private let tokenKey = "userAuthToken"
    
    // Function to securely store the token
    func saveToken(_ token: String) {
        do {
            let encryptionKey = SymmetricKey(size: .bits256)
            let iv = AES.GCM.Nonce()
            
            let tokenData = token.data(using: .utf8)!
            
            let sealedBox = try AES.GCM.seal(tokenData, using: encryptionKey, nonce: iv)
            
            let encryptedData = sealedBox.combined
            
            userDefaults.set(encryptedData, forKey: tokenKey)
        } catch {
            print("Error encrypting token: \(error.localizedDescription)")
        }
    }
    
    // Function to securely retrieve the token
    func getToken() -> String? {
        if let encryptedData = userDefaults.data(forKey: tokenKey) {
            do {
                let encryptionKey = SymmetricKey(size: .bits256)
                
                let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
                let decryptedData = try AES.GCM.open(sealedBox, using: encryptionKey)
                
                if let decryptedToken = String(data: decryptedData, encoding: .utf8) {
                    return decryptedToken
                } else {
                    return nil
                }
            } catch {
                print("Error decrypting token: \(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
}
