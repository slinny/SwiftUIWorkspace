//
//  NewsViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var images = [String: UIImage]()
    private let apiManager: NewsAPIManager
    
    init(apiManager: NewsAPIManager = NewsAPIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchArticles(from urlString: String) async {
        guard let data = await apiManager.fetchData(from: urlString) else {
            print(URLError.badServerResponse)
            return
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(Articles.self, from: data)
            DispatchQueue.main.async {
                self.articles = decodedResponse.articles
            }
        } catch {
            print(URLError.cannotDecodeRawData)
        }
    }
    
    func fetchArticleImages(from urlString: String) async {
        guard let data = await apiManager.fetchData(from: urlString) else {
            print(URLError.badServerResponse)
            return
        }
        DispatchQueue.main.async {
            self.images[urlString] = UIImage(data: data)
        }
    }
}
