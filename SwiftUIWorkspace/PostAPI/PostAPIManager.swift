//
//  APIManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import Foundation

class PostsAPIManager {
    private let urlSession: URLSessionProtocol
    private let baseUrl = Common.baseUrl.rawValue
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData() async throws -> Data? {
        guard let url = URL(string: baseUrl + "posts") else { return nil }
        let (data, _) = try await urlSession.fetchData(from: url)
        return data
    }
    
    func fetchPost(by id: Int) async throws -> Data? {
        guard let url = URL(string: baseUrl + "posts/\(id)") else { return nil }
        let (data, _) = try await urlSession.fetchData(from: url)
        return data
    }
    
    func postData(data: Data) async throws {
        guard let url = URL(string: baseUrl + "posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let (_, response) = try await urlSession.postData(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
    }
    
    func updatePost(id: Int, data: Data) async throws {
        guard let url = URL(string: baseUrl + "posts/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let (_, response) = try await urlSession.postData(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
    
    func deletePost(id: Int) async throws {
        guard let url = URL(string: baseUrl + "posts/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await urlSession.postData(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}





