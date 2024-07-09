//
//  Model.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/8/24.
//

import Foundation
import SwiftUI

class DubizzleData {
    static var services: [Service] = {
        var data = [Service]()
        for _ in 0..<9 {
            data.append(Service(imageName: "building.2", title: "Property for Rent"))
        }
        return data
    }()

    static var properties: [Property] = {
        var data = [Property]()
        for _ in 0..<9 {
            data.append(Property(thumbnail: "building", price: "100,000", numberOfBeds: 2, numberOfBathrooms: 1, address: "Paradise Lake B9"))
        }
        return data
    }()
    
    static let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}

struct Service {
    var imageName: String
    var title: String
}

struct Property {
    var thumbnail: String
    var price: String
    var numberOfBeds: Int
    var numberOfBathrooms: Int
    var address: String
}
