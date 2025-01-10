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
    func autocompleteForSearchText(_ searchText: String?, completion: @escaping ([SearchResult]) -> Void) {
        guard let query = searchText, !query.isEmpty else {
            completion([])
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let sampleResults = [
                SearchResult(id: UUID(), title: "\(query) Apple", description: "Description for Apple"),
                SearchResult(id: UUID(), title: "\(query) Banana", description: "Description for Banana"),
                SearchResult(id: UUID(), title: "\(query) Cherry", description: "Description for Cherry")
            ]
            
            completion(sampleResults)
        }
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
                        serverConnection.autocompleteForSearchText(newValue) { resultContents in
                            self.resultContents = resultContents
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
