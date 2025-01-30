//
//  GraphQLResponse.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

struct GraphQLResponse<T: Decodable>: Decodable {
    let data: T?
}

struct GraphQLDeleteItemResponse: Decodable {
    let deleteItem: GraphQLDeleteSuccess
}

struct GraphQLDeleteSuccess: Decodable {
    let success: Bool
}
