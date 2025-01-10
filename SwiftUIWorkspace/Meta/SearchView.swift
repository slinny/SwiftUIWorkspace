//
//  SearchView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 1/9/25.
//

import SwiftUI

struct SearchResult: Identifiable {
    let id: UUID
    let title: String
    let description: String
}

class ServerConnection {
    func autocompleteForSearchText(_ searchText: String) async throws -> [SearchResult] {
        guard !searchText.isEmpty else {
            return []
        }
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let sampleResults = [
            SearchResult(id: UUID(), title: "\(searchText) Apple", description: "Description for Apple"),
            SearchResult(id: UUID(), title: "\(searchText) Banana", description: "Description for Banana"),
            SearchResult(id: UUID(), title: "\(searchText) Cherry", description: "Description for Cherry")
        ]
        
        return sampleResults
    }
}

struct SearchView: View {
    
    @State var searchText: String = ""
    @State var resultContents: [SearchResult] = []
    
    var serverConnection = ServerConnection()
    @State private var searchDebounceTimer: Timer?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search...", text: $searchText)
                .padding()
                .frame(width: 300, height: 50, alignment: .leading)
                .border(Color.black)
                .onChange(of: searchText, { oldValue, newValue in
                    searchDebounceTimer?.invalidate()
                    searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                        Task {
                            do {
                                let results = try await serverConnection.autocompleteForSearchText(newValue)
                                await MainActor.run {
                                    self.resultContents = results
                                }
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    }
                })
            
            List(resultContents) { result in
                Text(result.title)
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .frame(width: 350, alignment: .leading)
        .padding()
    }
}

#Preview {
    SearchView()
}
