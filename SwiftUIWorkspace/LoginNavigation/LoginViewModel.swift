//
//  LoginViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/21/25.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    @Published var loginUser: LoginUser?
    @Published var showAlert = false
    @Published var errorMessage = ""

    func login() async {
        do {
            let fetchedUser = try await LoginAPIManager.shared.login(username: username, password: password)
            self.loginUser = fetchedUser
            self.isAuthenticated = true
        } catch {
            self.errorMessage = error.localizedDescription
            self.showAlert = true
        }
    }
}
