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
    
    let modelContainer: ModelContainer // SwiftData
    let persistenceController = PersistenceController.shared // CoreData
    
    // SwiftData
    init() {
        do {
            modelContainer = try ModelContainer(for: ToDoItem.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
//            ToDoListView()
//                .modelContainer(for: ToDoItem.self) // SwiftData
//                .environment(\.managedObjectContext, persistenceController.container.viewContext) // CoreData
//            FoodListView()
            BioAuthView()
        }
    }
}
