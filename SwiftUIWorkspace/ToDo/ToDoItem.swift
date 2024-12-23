//
//  ToDoItem.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 12/21/24.
//

import Foundation
import SwiftData

@Model
final class ToDoItem: Identifiable, Hashable {
    var id: UUID
    var text: String
    var time: Date
    
    init(id: UUID = UUID(), text: String = "", time: Date = Date()) {
        self.id = id
        self.text = text
        self.time = time
    }
}

extension ToDoItem {
    static var sample: [ToDoItem] = [
        ToDoItem(text: "A SwiftUI workspace for building iOS apps"),
        ToDoItem(text: "A SwiftUI workspace for building iOS apps"),
        ToDoItem(text: "A SwiftUI workspace for building iOS apps"),
        ToDoItem(text: "A SwiftUI workspace for building iOS apps"),
        ToDoItem(text: "A SwiftUI workspace for building iOS apps")
    ]
}
