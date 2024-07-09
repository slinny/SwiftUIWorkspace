//
//  SwiftUIView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/8/24.
//

import SwiftUI

struct DubizzleLoginView: View {
    
    var body: some View {
        NavigationStack {
            loginTopView()
            loginMethodsView()
            registerView()
            Spacer()
        }
    }
}

extension DubizzleLoginView {
    private func loginTopView() -> some View {
        VStack {
            Image(systemName: "water.waves")
                .resizable()
                .frame(width: 200, height: 30)
                .padding(.top, 50)
            Image(systemName: "note.text")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
                .padding(.top, 30)
            Text("Log in to post an ad")
                .font(.title)
                .bold()
                .padding()
        }
    }
    
    private func loginMethodsView() -> some View {
       VStack {
            HStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .padding(.leading, 80)
                Button {
                    
                } label: {
                    Text("Continue with Facebook")
                }
                Spacer()
            }
            .padding(.top)
            
            HStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .padding(.leading, 80)
                Button {
                    
                } label: {
                    Text("Continue with Google")
                }
                Spacer()
            }
            .padding(.top)
            
            HStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .padding(.leading, 80)
                Button {
                    
                } label: {
                    Text("Continue with Apple")
                }
                Spacer()
            }
            .padding(.top)
            
            HStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .padding(.leading, 80)
                Button {
                    
                } label: {
                    Text("Continue with Email")
                }
                Spacer()
            }
            .padding(.top)
        }
    }
    
    private func registerView() -> some View {
        return VStack {
            NavigationLink(destination: DubizzleRegisterView()) {
                Text("Dont't have an account? Create one")
                    .foregroundColor(.red)
                    .bold()
            }
            .padding()
            
//            Button {
//                
//            } label: {
//                Text("Dont't have an account? Create one")
//                    .foregroundColor(.red)
//                    .bold()
//            }
//            .padding()
            
            HStack {
                Text("By logging in I agree to the")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button {
                    
                } label: {
                    Text("Terms and Conditions")
                        .font(.footnote)
                }
                Text("and")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Button {
                
            } label: {
                Text("Privacy Policy")
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    DubizzleLoginView()
}
