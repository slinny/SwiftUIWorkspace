//
//  MusicListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/8/24.
//

import SwiftUI

struct MusicListView: View {
    var body: some View {
        HStack {
            Text("Top Songs")
                .foregroundColor(.blue)
                .font(.title)
                .bold()
                .frame(alignment: .leading)
                .padding()
            Spacer()
        }
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray),
            alignment: .bottom 
        )
        ScrollView {
            VStack {
                ForEach(1..<10) { index in
                    HStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 140, height: 140)
                            .padding()
                        VStack {
                            Text("Song Name")
                                .font(.title3)
                                .bold()
                            Text("Artist Name")
                                .font(.title3)
                        }
                        Spacer()
                    }
                    .frame(height: 170)
                }
            }
        }
    }
}

#Preview {
    MusicListView()
}
