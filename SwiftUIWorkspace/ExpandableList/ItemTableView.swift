//
//  TableView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 6/28/24.
//

import SwiftUI

struct ItemTableView: View {
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.itemLists) { itemList in
                VStack(alignment: .leading) {
                    HStack {
                        Text(itemList.title)
                            .font(.headline)
                        Spacer()
                        Image(systemName: viewModel.isListExpanded(itemList) ? "chevron.up" : "chevron.down")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                viewModel.toggleListExpansion(for: itemList)
                            }
                    }
                    if viewModel.isListExpanded(itemList) {
                        VStack {
                            ForEach(itemList.items) { item in
                                VStack {
                                    Divider()
                                    HStack {
                                        Text(item.title)
                                        Spacer()
                                            .frame(width: 50)
                                        Text(item.description)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ItemTableView()
}
