//
//  UserGQL.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

struct GraphQLUser: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
}
