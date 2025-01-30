//
//  GraphQLUserListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import SwiftUI

struct GraphQLUserListView: View {
    @State private var viewModel = GraphQLUserViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Fetch Users") {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}

#Preview {
    GraphQLUserListView()
}
