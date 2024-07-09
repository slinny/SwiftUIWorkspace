//
//  Dummy.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 6/28/24.
//

import Foundation

struct ItemList: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let items: [Item]
}

struct Item: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
}
