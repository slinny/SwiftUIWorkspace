//
//  AddTypicodeView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/18/24.
//

import SwiftUI

struct AddPostView: View {
    
    @State private var postTitle: String = ""
    @State private var postBody: String = ""
    @State private var userID: String = ""
    @State private var isSubmitted: Bool = false
    @State private var showAlert: Bool = false
    
    @EnvironmentObject var viewModel: PostViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(placeholder: "Title", text: $postTitle)
                CustomTextField(placeholder: "Body", text: $postBody)
                CustomTextField(placeholder: "UserID", text: $userID)
                
                Button(action: {
                    Task {
                        await saveData()
                    }
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
                }
                
                Spacer()
            }
            .navigationBarTitle("Add New Post")
            .navigationDestination(isPresented: $isSubmitted) {
                PostsListView()
            }
        }
    }
}

extension AddPostView {
    func saveData() async {
        guard let userId = Int(userID), !postTitle.isEmpty, !postBody.isEmpty else {
            viewModel.errorMessage = "Please fill in all fields correctly."
            showAlert = true
            return
        }
        
        let newPost = PostModel(userId: userId, id: 0, title: postTitle, body: postBody)
        
        await viewModel.createPost(post: newPost)
        if viewModel.errorMessage == nil {
            isSubmitted = true
        } else {
            showAlert = true
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        } else {
            TextField(placeholder, text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView().environmentObject(PostViewModel(apiManager: PostsAPIManager(), jsonParser: PostJsonParser()))
    }
}


