//
//  NewsListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import Foundation

class NewsAPIManager {
    static let shared = NewsAPIManager()
    
    func fetchData(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {
            print("Error: \(URLError.badURL)")
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: \(URLError.badServerResponse)")
                return nil
            }
            return data
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
