//
//  KeychainHelper.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}
    
    func save(_ data: Data, for service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    func retrieve(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
    
    func delete(service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
}

/*
 https://www.youtube.com/watch?v=NCREPNvFpjk
 
 MARK: Saving Data
 if let data = "mySensitiveData".data(using: .utf8) {
     let success = KeychainHelper.shared.save(data, for: "com.myapp.service", account: "userAccount")
     print("Save successful: \(success)")
 }

 MARK: Retriving Data
 if let retrievedData = KeychainHelper.shared.retrieve(service: "com.myapp.service", account: "userAccount"),
    let dataString = String(data: retrievedData, encoding: .utf8) {
     print("Retrieved data: \(dataString)")
 } else {
     print("No data found")
 }

 MARK: Deleting Data
 let success = KeychainHelper.shared.delete(service: "com.myapp.service", account: "userAccount")
 print("Delete successful: \(success)")
 
 */
