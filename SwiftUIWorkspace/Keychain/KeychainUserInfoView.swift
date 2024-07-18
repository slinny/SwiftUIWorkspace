//
//  KeychainUserInfoView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/17/24.
//

import SwiftUI

struct KeychainUserInfoView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("User Info")
                .font(.largeTitle)
                .padding()
            Text("Username: \(username)")
            Text("Password: \(password)")
            Spacer()
        }
        .onAppear {
            loadCredentials()
        }
    }
}

extension KeychainUserInfoView {
    private func loadCredentials() {
        if let usernameData = KeychainHelper.shared.retrieve(service: "com.example.app.username", account: "userAccount"),
           let passwordData = KeychainHelper.shared.retrieve(service: "com.example.app.password", account: "userAccount") {
            username = String(data: usernameData, encoding: .utf8) ?? ""
            password = String(data: passwordData, encoding: .utf8) ?? ""
        }
    }
}

#Preview {
    KeychainUserInfoView()
}
