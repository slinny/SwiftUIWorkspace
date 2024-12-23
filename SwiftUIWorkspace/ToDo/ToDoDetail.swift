//
//  ToDoDetail.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 12/21/24.
//

import SwiftUI
import SwiftData

struct ToDoDetail: View {
    @Bindable var todoItem: ToDoItem
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("new item", text: $todoItem.text)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    Task {
                        try modelContext.save()
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoDetail(todoItem: ToDoItem(id: UUID(), text: "Text"))
}
