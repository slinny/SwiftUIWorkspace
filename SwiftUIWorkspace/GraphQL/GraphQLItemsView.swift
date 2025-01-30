//
//  GraphQLView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import SwiftUI

struct GraphQLItemsView: View {
    @State private var viewModel = GraphQLItemsViewModel()
    @State private var showAddItemSheet = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading items...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(viewModel.items) { item in
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                }
            }
            .navigationTitle("GraphQL Items")
            .toolbar {
                Button(action: { showAddItemSheet.toggle() }) {
                    Image(systemName: "plus")
                }
            }
            .task {
                await viewModel.loadItems()
            }
            .sheet(isPresented: $showAddItemSheet) {
                GraphQLAddItemView(viewModel: viewModel)
            }
        }
    }

    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = viewModel.items[index]
            Task {
                await viewModel.deleteItem(id: item.id)
            }
        }
    }
}


#Preview {
    GraphQLItemsView()
}
