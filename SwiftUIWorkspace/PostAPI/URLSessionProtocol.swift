//
//  URLSessionProtocol.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/19/24.
//

import Foundation

protocol URLSessionProtocol {
    func fetchData(from url: URL) async throws -> (Data, URLResponse)
    func postData(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        return try await data(from: url)
    }
    
    func postData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await data(for: request)
    }
}
