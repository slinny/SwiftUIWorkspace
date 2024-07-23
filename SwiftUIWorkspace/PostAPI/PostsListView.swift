//
//  PostsListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import SwiftUI

struct PostsListView: View {
    @EnvironmentObject var viewModel: PostViewModel
    
    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .font(.subheadline)
            }
        }
        .navigationTitle("Posts")
        .onAppear {
            Task {
                await viewModel.fetchPosts()
            }
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView().environmentObject(PostViewModel(apiManager: PostsAPIManager(), jsonParser: PostJsonParser()))
    }
}

