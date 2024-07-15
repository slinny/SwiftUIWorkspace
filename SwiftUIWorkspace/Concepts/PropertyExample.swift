//
//  Property.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/10/24.
//

import Foundation

struct Temperature {
    var celsius: Double
    
    // Stored property
    var fahrenheit: Double {
        get {
            return celsius * 9 / 5 + 32
        }
        set {
            celsius = (newValue - 32) * 5 / 9
        }
    }
    
    // Lazy stored property
    lazy var kelvin: Double = {
        return celsius + 273.15
    }()
    
    // Read-only computed property
    var description: String {
        return "Temperature in Celsius: \(celsius), Fahrenheit: \(fahrenheit)"
    }
}

/*
 var temp = Temperature(celsius: 25)
 print(temp.fahrenheit) // Prints: 77.0
 print(temp.kelvin) // Prints: 298.15
 print(temp.description) // Prints: Temperature in Celsius: 25.0, Fahrenheit: 77.0, Kelvin: 298.15
 temp.fahrenheit = 100
 print(temp.celsius) // Prints: 37.77777777777778
 print(temp.description) // Prints: Temperature in Celsius: 37.77777777777778, Fahrenheit: 100.0, Kelvin: 310.92777777777775
 */

// MARK: property observers
struct Temperature2 {
    var celsius: Double {
        willSet {
            print("About to set celsius to \(newValue)")
        }
        didSet {
            print("Did set celsius from \(oldValue) to \(celsius)")
        }
    }
    
    var fahrenheit: Double {
        get {
            return celsius * 9 / 5 + 32
        }
        set {
            celsius = (newValue - 32) * 5 / 9
        }
    }
    
    init(celsius: Double) {
        self.celsius = celsius
        print("Initialized with celsius: \(celsius)")
    }
}

/*
 var temp = Temperature(celsius: 25)
 // Output:
 // Initialized with celsius: 25.0
 temp.celsius = 30
 // Output:
 // About to set celsius to 30.0
 // Did set celsius from 25.0 to 30.0

 temp.fahrenheit = 86
 // Output:
 // About to set celsius to 30.0
 // Did set celsius from 25.0 to 30.0
 */

