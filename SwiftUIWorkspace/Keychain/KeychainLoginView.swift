//
//  KeychainLoginView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/17/24.
//

import SwiftUI

struct KeychainLoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State private var isNavigationActive = false
    @State private var errorMessage: String?
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            let loginOptions: [(String, String, Binding<String>)] = [
                ("person.fill", "username", $username),
                ("lock.fill", "password", $password)
            ]
            
            VStack {
                Text("Let's Get Started!")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 80)
                Text("Create an account")
                    .padding(.bottom)
                
                ForEach(0..<loginOptions.count, id: \.self) { index in
                    LoginOptionView(imageName: loginOptions[index].0, placeholder: loginOptions[index].1, input: loginOptions[index].2)
                }
                
                Button("Username and Password Rules") {
                    showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Username and Password Rules"),
                        message: Text("Username must be at least 5 characters long and can only contain letters and numbers. Password must be at least 8 characters long, contains at least one upper case letter, one lower case letter, one number and one special character."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    saveCredentials()
                }) {
                    Text("CREATE")
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(20)
                .padding(.top, 40)
                
                HStack {
                    Text("Already have an account?")
                    Button(action: {
                        
                    }) {
                        Text("Login Here")
                    }
                }
                .padding(.top, 80)
                Spacer()
            }
            .navigationDestination(isPresented: $isNavigationActive) {
                KeychainUserInfoView()
            }
        }
    }
}

extension KeychainLoginView{
    private func saveCredentials() {
        if validateUsername(username) && validatePassword(password) {
            guard let usernameData = username.data(using: .utf8),
                  let passwordData = password.data(using: .utf8) else {
                return
            }
            
            let usernameSaved = KeychainHelper.shared.save(usernameData, for: "com.example.app.username", account: "userAccount")
            let passwordSaved = KeychainHelper.shared.save(passwordData, for: "com.example.app.password", account: "userAccount")
            
            if usernameSaved && passwordSaved {
                print("Credentials saved successfully!")
                isNavigationActive = true
            } else {
                print("Failed to save credentials.")
            }
        }
    }
    
    private func validateUsername(_ username: String) -> Bool {
        if username.isEmpty {
            errorMessage = "Username cannot be empty."
            return false
        }
        if username.count < 5 {
            errorMessage = "Username must be at least 5 characters long."
            return false
        }
        let usernameRegex = "^[a-zA-Z0-9]+$"
        if !NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: username) {
            errorMessage = "Username can only contain letters and numbers."
            return false
        }
        errorMessage = nil
        return true
    }
    
    private func validatePassword(_ password: String) -> Bool {
        if password.count < 8 {
            errorMessage = "Password must be at least 8 characters long."
            return false
        }
        let uppercaseRegex = ".*[A-Z]+.*"
        let lowercaseRegex = ".*[a-z]+.*"
        let digitRegex = ".*[0-9]+.*"
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        
        if !NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: password) {
            errorMessage = "Password must contain at least one uppercase letter."
            return false
        }
        if !NSPredicate(format: "SELF MATCHES %@", lowercaseRegex).evaluate(with: password) {
            errorMessage = "Password must contain at least one lowercase letter."
            return false
        }
        if !NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: password) {
            errorMessage = "Password must contain at least one digit."
            return false
        }
        if !NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password) {
            errorMessage = "Password must contain at least one special character."
            return false
        }
        errorMessage = nil
        return true
    }
}

#Preview {
    KeychainLoginView()
}

struct KeychainLoginOptionView: View {
    var imageName: String
    var placeholder: String
    @Binding var input: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
            TextField(placeholder, text: $input)
                .padding()
                .frame(width: 250, height: 50)
                .border(Color.gray)
                .autocorrectionDisabled()
                .autocapitalization(.none)
        }
        .frame(height: 60)
    }
}
