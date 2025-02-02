//
//  FoodViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 2/2/25.
//

import Foundation

@Observable
class FoodViewModel {
    var foodItems: [FoodItem] = []
    
    func saveFoodItem(name: String, calories: String) {
        foodItems.append(FoodItem(name: name, calories: Int(calories)!))
        print(foodItems)
    }
    
    func isValidName(name: String) -> Bool {
        if name.isEmpty {
            return false
        }
        return true
    }
    
    func isValidCalories(calories: String) -> Bool {
        if calories.isEmpty {
            return false
        }
        if let _ = Int(calories) {
            return true
        }
        return false
    }
}
