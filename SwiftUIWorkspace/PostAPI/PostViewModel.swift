//
//  PostViewModel.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var post: PostModel? = nil
    @Published var errorMessage: String?
    
    private let apiManager: PostsAPIManager
    private let jsonParser: PostJsonParser
    
    init(apiManager: PostsAPIManager, jsonParser: PostJsonParser) {
        self.apiManager = apiManager
        self.jsonParser = jsonParser
    }
    
    func fetchPosts() async {
        do {
            if let data = try await apiManager.fetchData() {
                let posts = try await jsonParser.decodePosts(data: data)
                await MainActor.run {
                    self.posts = posts
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to fetch or decode posts: \(error)"
            }
        }
    }
    
    func fetchPost(by id: Int) async {
        do {
            if let data = try await apiManager.fetchPost(by: id) {
                let post = try await jsonParser.decodePost(data: data)
                await MainActor.run {
                    self.post = post
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to fetch or decode post: \(error)"
            }
        }
    }
    
    func createPost(post: PostModel) async {
        do {
            let data = try await jsonParser.encodeData(model: post)
            try await apiManager.postData(data: data)
            await fetchPosts()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to create post: \(error)"
            }
        }
    }
    
    func updatePost(post: PostModel) async {
        do {
            let data = try await jsonParser.encodeData(model: post)
            try await apiManager.updatePost(id: post.id, data: data)
            await fetchPosts()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to update post: \(error)"
            }
        }
    }
    
    func deletePost(id: Int) async {
        do {
            try await apiManager.deletePost(id: id)
            await fetchPosts()
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to delete post: \(error)"
            }
        }
    }
}





