//
//  LoginAPIManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/21/25.
//

import Foundation

class LoginAPIManager {
    static let shared = LoginAPIManager()
    
    func login(username: String, password: String) async throws -> LoginUser {
        let url = URL(string: "https://api.example.com/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["username": username, "password": password]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        if decodedResponse.status == "success", let user = decodedResponse.loginUser {
            return user
        } else {
            throw NSError(domain: "LoginError", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        }
    }
}
