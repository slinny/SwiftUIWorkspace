//
//  ItunesViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/3/24.
//

import Foundation
import Combine

class ItunesViewModel: ObservableObject {
    
    @Published var artists: [Artist] = []
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchArtists(from urlString: String) {
        apiManager.fetchData(from: urlString) { [weak self] (result: Swift.Result<Artists, Error>) in
            switch result {
            case .success(let artists):
                self?.artists = artists.results
            case .failure(let error):
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .badURL:
                        print("Bad URL error occurred")
                    default:
                        print("URL Error: \(urlError.localizedDescription)")
                    }
                } else if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .typeMismatch(_, let context),
                         .valueNotFound(_, let context),
                         .keyNotFound(_, let context),
                         .dataCorrupted(let context):
                        print("Decoding error: \(context.debugDescription)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                } else {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}


