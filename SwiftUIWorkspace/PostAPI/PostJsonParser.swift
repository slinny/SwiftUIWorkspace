//
//  JsonParser.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import Foundation

class PostJsonParser {
    
    func decodePosts(data: Data) async throws -> [PostModel] {
        let decoder = JSONDecoder()
        return try decoder.decode([PostModel].self, from: data)
    }
    
    func decodePost(data: Data) async throws -> PostModel {
        let decoder = JSONDecoder()
        return try decoder.decode(PostModel.self, from: data)
    }
    
    func encodeData(model: PostModel) async throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(model)
    }
}
