//
//  NewsModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import Foundation

// MARK: - Articles
struct Articles: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
