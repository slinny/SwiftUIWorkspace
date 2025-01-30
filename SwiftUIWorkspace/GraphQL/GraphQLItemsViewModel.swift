//
//  GraphQLItemViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/30/25.
//

import Foundation

@Observable
@MainActor
class GraphQLItemsViewModel {
    var items: [GraphQLItem] = []
    var isLoading = false
    var errorMessage: String?

    private let client = GraphQLClient()

    func loadItems() async {
        isLoading = true
        do {
            let fetchedItems = try await client.fetchItems()
            items = fetchedItems
        } catch {
            errorMessage = "Failed to load items: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func addItem(name: String, description: String) async {
        isLoading = true
        do {
            let newItem = try await client.createItem(name: name, description: description)
            items.append(newItem)
        } catch {
            errorMessage = "Failed to add item: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func updateItem(id: String, name: String, description: String) async {
        isLoading = true
        do {
            let updatedItem = try await client.updateItem(id: id, name: name, description: description)
            if let index = items.firstIndex(where: { $0.id == id }) {
                items[index] = updatedItem
            }
        } catch {
            errorMessage = "Failed to update item: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func deleteItem(id: String) async {
        isLoading = true
        do {
            let success = try await client.deleteItem(id: id)
            if success {
                items.removeAll { $0.id == id }
            }
        } catch {
            errorMessage = "Failed to delete item: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
