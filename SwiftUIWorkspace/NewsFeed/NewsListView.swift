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
                            if let image = viewModel.images[imageURL] {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(10)
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                                    .padding(10)
                                    .onAppear {
                                        Task {
                                            await viewModel.fetchArticleImages(from: imageURL)
                                        }
                                    }
                            }
                        } else {
                            Image(systemName: "book")
                                .resizable()
                                .frame(width: 50, height: 50)
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
        .onAppear{
            Task {
                await viewModel.fetchArticles(from: NewsConstants.articleUrl.rawValue)
            }
        }
    }
}

#Preview {
    NewsListView()
}
