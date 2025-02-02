//
//  FoodItem.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/2/25.
//

import Foundation

struct FoodItem: Identifiable {
    let id = UUID()
    var name: String
    var calories: Int
}
