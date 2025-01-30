//
//  GraphQLAPIManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

class GraphQLAPIManager {
    static let shared = GraphQLAPIManager()
    private let url = URL(string: "https://your-graphql-endpoint.com/graphql")!

    func performRequest<T: Decodable>(query: String, variables: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "query": query,
            "variables": variables ?? [:]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GraphQLResponse<T>.self, from: data)
                completion(.success(decodedResponse.data!))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
