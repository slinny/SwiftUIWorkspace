//
//  Artists.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/3/24.
//

import Foundation

// MARK: model classes
struct Artists: Codable {
    let results: [Artist]
}

struct Artist: Codable {
    let wrapperType: String?
    let artistName: String?
    let collectionPrice: Double?
    let country: Country?
    let primaryGenreName: String?
    let artworkUrl60: String?
}

enum Country: String, Codable {
    case usa = "USA"
}
