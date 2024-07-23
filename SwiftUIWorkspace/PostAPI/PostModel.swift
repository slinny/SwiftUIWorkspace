//
//  PostModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import Foundation

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
