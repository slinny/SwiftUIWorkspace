//
//  GraphQLClient.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

class GraphQLClient {
    private let url = URL(string: "https://yourgraphqlapi.com/graphql")!

    func fetchItems() async throws -> [GraphQLItem] {
        let query = """
        {
            items {
                id
                name
                description
            }
        }
        """
        return try await performRequest(query: query, variables: nil)
    }
    
    func createItem(name: String, description: String) async throws -> GraphQLItem {
        let mutation = """
        mutation CreateItem($name: String!, $description: String!) {
            createItem(name: $name, description: $description) {
                id
                name
                description
            }
        }
        """
        let variables: [String: Any] = ["name": name, "description": description]
        return try await performRequest(query: mutation, variables: variables)
    }

    func updateItem(id: String, name: String, description: String) async throws -> GraphQLItem {
        let mutation = """
        mutation UpdateItem($id: ID!, $name: String!, $description: String!) {
            updateItem(id: $id, name: $name, description: $description) {
                id
                name
                description
            }
        }
        """
        let variables: [String: Any] = ["id": id, "name": name, "description": description]
        return try await performRequest(query: mutation, variables: variables)
    }

    func deleteItem(id: String) async throws -> Bool {
        let mutation = """
        mutation DeleteItem($id: ID!) {
            deleteItem(id: $id) {
                success
            }
        }
        """
        let variables: [String: Any] = ["id": id]
        let response: GraphQLDeleteItemResponse = try await performRequest(query: mutation, variables: variables)
        return response.deleteItem.success
    }

    private func performRequest<T: Decodable>(query: String, variables: [String: Any]?) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "query": query,
            "variables": variables ?? [:]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(GraphQLResponse<T>.self, from: data)
        
        if let responseData = result.data {
            return responseData
        } else {
            throw NSError(domain: "No data", code: -1, userInfo: nil)
        }
    }
}
