//
//  ToDoListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 12/21/24.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(
        sort: \ToDoItem.time,
        order: .reverse
    ) private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(item.text, destination: ToDoDetail(todoItem: item))
            }
            .listStyle(.plain)
            .navigationTitle("ToDo List")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ToDoDetail(todoItem: ToDoItem())) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            })
        }
    }
}

#Preview {
    ToDoListView()
}
