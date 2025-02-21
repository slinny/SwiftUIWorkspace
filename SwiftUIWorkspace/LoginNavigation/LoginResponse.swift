//
//  User.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/21/25.
//

import Foundation

struct LoginResponse: Codable {
    let status: String
    let loginUser: LoginUser?
}

struct LoginUser: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
