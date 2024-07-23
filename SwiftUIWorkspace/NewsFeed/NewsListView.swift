//
//  NewsListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.articles.indices, id: \.self) { index in
                    let article = viewModel.articles[index]
                    HStack {
                        if let imageURL = article.urlToImage {
                            AsyncImage(urlString: imageURL)
                                .frame(width: 50, height: 50)
                                .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                .padding(10)
                        } else {
                            Image(systemName: "")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                .padding(10)
                        }
                        VStack(alignment: .leading) {
                            Text(article.title ?? "title")
                                .bold()
                            Text(article.author ?? "author")
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .frame(height: 70)
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 0.5)
                            .frame(height: 0.5),
                        alignment: .bottom
                    )
                    
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchArticles(from: NewsConstants.articleUrl.rawValue)
        }
    }
}

#Preview {
    NewsListView()
}
