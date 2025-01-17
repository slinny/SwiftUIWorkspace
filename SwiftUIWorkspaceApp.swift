//
//  SwiftUIWorkspaceApp.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 6/27/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftUIWorkspaceApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ToDoItem.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDoItem.self)
        }
    }
}
