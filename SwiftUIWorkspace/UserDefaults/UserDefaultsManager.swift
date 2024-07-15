//
//  UserDefaultsManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/15/24.
//

import Foundation

/*
 // Setting values
 UserDefaultsManager.shared.username = "JohnDoe"
 UserDefaultsManager.shared.isLoggedIn = true
 UserDefaultsManager.shared.preferredTheme = .dark

 // Getting values
 let username = UserDefaultsManager.shared.username
 let isLoggedIn = UserDefaultsManager.shared.isLoggedIn
 let preferredTheme = UserDefaultsManager.shared.preferredTheme

 // Clearing user data
 UserDefaultsManager.shared.clearUserData()
 */

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    // Keys
    private struct Keys {
        static let username = "username"
        static let isLoggedIn = "isLoggedIn"
        static let preferredTheme = "preferredTheme"
    }
    
    // User properties
    var username: String? {
        get {
            return userDefaults.string(forKey: Keys.username)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.username)
        }
    }
    
    var isLoggedIn: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isLoggedIn)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.isLoggedIn)
        }
    }
    
    var preferredTheme: Theme {
        get {
            if let savedTheme = userDefaults.string(forKey: Keys.preferredTheme) {
                return Theme(rawValue: savedTheme) ?? .light
            }
            return .light
        }
        set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.preferredTheme)
        }
    }
    
    // Clear all user data
    func clearUserData() {
        userDefaults.removeObject(forKey: Keys.username)
        userDefaults.removeObject(forKey: Keys.isLoggedIn)
        userDefaults.removeObject(forKey: Keys.preferredTheme)
    }
}

// Example Theme enum
enum Theme: String {
    case light
    case dark
}

