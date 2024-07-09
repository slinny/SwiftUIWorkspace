//
//  WebView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/2/24.
//

import SwiftUI

struct WebHomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: WebView(url: URL(string: "https://www.example.com")!)) {
                    Text("Open WebView")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Web Home View")
        }
    }
}

#Preview {
    WebHomeView()
}
