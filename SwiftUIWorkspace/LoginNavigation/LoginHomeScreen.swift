//
//  HomeScreen.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/21/25.
//

import SwiftUI

struct LoginHomeScreen: View {
    let user: LoginUser

    var body: some View {
        VStack {
            Text("Welcome, \(user.name)!")
                .font(.largeTitle)
                .padding()

            Text("Email: \(user.email)")
                .font(.title2)

            Spacer()
        }
        .navigationTitle("Home")
    }
}

#Preview {
    LoginHomeScreen(user: LoginUser(id: 1, name: "John Doe", email: "johndoe@example.com"))
}
