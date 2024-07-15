//
//  InitializerExample.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/10/24.
//

import Foundation

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // Convenience initializer
    convenience init(name: String) {
        self.init(name: name, age: 0) // Default age to 0
    }
}

let baby = Person(name: "Baby")
// Uses convenience initializer
