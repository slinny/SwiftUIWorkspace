//
//  GraphQLAddItemView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import SwiftUI

struct GraphQLAddItemView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: GraphQLItemsViewModel
    @State private var name = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await viewModel.addItem(name: name, description: description)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    GraphQLAddItemView(viewModel: GraphQLItemsViewModel())
}
