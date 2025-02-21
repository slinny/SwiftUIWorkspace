//
//  LoginScreen.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/21/25.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()

                if let loginUser = viewModel.loginUser {
                    NavigationLink(
                        destination: LoginHomeScreen(user: loginUser),
                        isActive: $viewModel.isAuthenticated
                    ) {
                        EmptyView()
                    }
                }
                
            }
            .alert("Login Failed", isPresented: $viewModel.showAlert, actions: {}) {
                Text(viewModel.errorMessage)
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginScreen()
}
