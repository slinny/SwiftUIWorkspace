//
//  ViewModelGraphQL.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

@Observable
class GraphQLUserViewModel {
    var users: [GraphQLUser] = []
    
    // Fetch Users (Read)
    func fetchUsers() {
        let query = """
        query {
          users {
            id
            name
            email
          }
        }
        """
        
        GraphQLAPIManager.shared.performRequest(query: query, variables: nil) { (result: Result<[String: [GraphQLUser]], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.users = response["users"] ?? []
                case .failure(let error):
                    print("Error fetching users: \(error)")
                }
            }
        }
    }
    
    // Create User (Create)
    func createUser(name: String, email: String) {
        let mutation = """
        mutation CreateUser($name: String!, $email: String!) {
          createUser(name: $name, email: $email) {
            id
            name
            email
          }
        }
        """
        
        let variables: [String: Any] = ["name": name, "email": email]
        
        GraphQLAPIManager.shared.performRequest(query: mutation, variables: variables) { (result: Result<[String: GraphQLUser], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let newUser = response["createUser"] {
                        self.users.append(newUser)
                    }
                case .failure(let error):
                    print("Error creating user: \(error)")
                }
            }
        }
    }
    
    // Update User (Update)
    func updateUser(id: String, name: String, email: String) {
        let mutation = """
        mutation UpdateUser($id: ID!, $name: String!, $email: String!) {
          updateUser(id: $id, name: $name, email: $email) {
            id
            name
            email
          }
        }
        """
        
        let variables: [String: Any] = ["id": id, "name": name, "email": email]
        
        GraphQLAPIManager.shared.performRequest(query: mutation, variables: variables) { (result: Result<[String: GraphQLUser], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let updatedUser = response["updateUser"] {
                        if let index = self.users.firstIndex(where: { $0.id == id }) {
                            self.users[index] = updatedUser
                        }
                    }
                case .failure(let error):
                    print("Error updating user: \(error)")
                }
            }
        }
    }
    
    // Delete User (Delete)
    func deleteUser(id: String) {
        let mutation = """
        mutation DeleteUser($id: ID!) {
          deleteUser(id: $id) {
            id
          }
        }
        """
        
        let variables: [String: Any] = ["id": id]
        
        GraphQLAPIManager.shared.performRequest(query: mutation, variables: variables) { (result: Result<[String: GraphQLUser], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.users.removeAll { $0.id == id }
                case .failure(let error):
                    print("Error deleting user: \(error)")
                }
            }
        }
    }
}
