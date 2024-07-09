//
//  LoginView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/1/24.
//

import SwiftUI

struct LoginView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    @State var validatePassword: String = ""
    
    var body: some View {
        let loginOptions: [(String, String, Binding<String>)] = [
            ("person.fill", "name", $name),
            ("envelope.fill", "Email", $email),
            ("iphone", "Phone", $phone),
            ("lock.fill", "Password", $password),
            ("lock.fill", "Confirm Password", $validatePassword)
        ]
        
        VStack {
            Text("Let's Get Started!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 80)
            Text("Create an account to Q Allure to get all features")
                .padding(.bottom)
            
            ForEach(0..<loginOptions.count, id: \.self) { index in
                LoginOptionView(imageName: loginOptions[index].0, placeholder: loginOptions[index].1, input: loginOptions[index].2)
            }
            
            Button(action: {
                
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
    }
}

#Preview {
    LoginView()
}

struct LoginOptionView: View {
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
        }
        .frame(height: 60)
    }
}
