//
//  APIManager.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import Foundation
import Combine

protocol APIManagerProtocol {
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { decodedResponse in
                completion(.success(decodedResponse))
            })
            .store(in: &cancellables)
    }
}
