//
//  DummyViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 6/28/24.
//

import Foundation

class ItemViewModel: ObservableObject {
    @Published var itemLists: [ItemList]
    @Published var expandedItemLists: Set<ItemList> = []
    @Published var expandedItems: Set<Item> = []
    
    init() {
        let itemList1 = ItemList(
            title: "List1",
            items: [
            Item(title: "Item 1.1", description: "Description for Item 1.1"),
            Item(title: "Item 1.2", description: "Description for Item 1.2"),
            Item(title: "Item 1.3", description: "Description for Item 1.3"),
            Item(title: "Item 1.4", description: "Description for Item 1.4"),
        ])
        
        let itemList2 = ItemList(
            title: "List2",
            items: [
            Item(title: "Item 2.1", description: "Description for Item 2.1"),
            Item(title: "Item 2.2", description: "Description for Item 2.2")
        ])
        
        self.itemLists = [itemList1, itemList2]
    }
    
    func isListExpanded(_ itemList: ItemList) -> Bool {
        expandedItemLists.contains(itemList)
    }
    
    func toggleListExpansion(for itemList: ItemList) {
        if expandedItemLists.contains(itemList) {
            expandedItemLists.remove(itemList)
        } else {
            expandedItemLists.insert(itemList)
        }
    }
}
