//
//  UserDefaultsManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/15/24.
//

import Foundation

/*
 // Setting values with custom keys
 UserDefaultsManager.shared.setUsername("JohnDoe", forKey: "customUsernameKey")
 UserDefaultsManager.shared.setIsLoggedIn(true, forKey: "customIsLoggedInKey")
 UserDefaultsManager.shared.setPreferredTheme(.dark, forKey: "customPreferredThemeKey")

 // Getting values with custom keys
 let username = UserDefaultsManager.shared.getUsername(forKey: "customUsernameKey")
 let isLoggedIn = UserDefaultsManager.shared.getIsLoggedIn(forKey: "customIsLoggedInKey")
 let preferredTheme = UserDefaultsManager.shared.getPreferredTheme(forKey: "customPreferredThemeKey")

 // Clearing data for specific keys
 UserDefaultsManager.shared.clearData(forKey: "customUsernameKey")
 UserDefaultsManager.shared.clearData(forKey: "customIsLoggedInKey")
 UserDefaultsManager.shared.clearData(forKey: "customPreferredThemeKey")
 */

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    // User properties with custom keys
    func setUsername(_ username: String?, forKey key: String) {
        userDefaults.setValue(username, forKey: key)
    }
    
    func getUsername(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func setIsLoggedIn(_ isLoggedIn: Bool, forKey key: String) {
        userDefaults.setValue(isLoggedIn, forKey: key)
    }
    
    func getIsLoggedIn(forKey key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func setPreferredTheme(_ theme: Theme, forKey key: String) {
        userDefaults.setValue(theme.rawValue, forKey: key)
    }
    
    func getPreferredTheme(forKey key: String) -> Theme {
        if let savedTheme = userDefaults.string(forKey: key) {
            return Theme(rawValue: savedTheme) ?? .light
        }
        return .light
    }
    
    // Clear data for a specific key
    func clearData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

// Example Theme enum
enum Theme: String {
    case light
    case dark
}


