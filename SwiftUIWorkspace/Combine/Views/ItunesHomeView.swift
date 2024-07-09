//
//  ListView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/3/24.
//

import SwiftUI

struct ItunesHomeView: View {
    @StateObject var viewModel: ItunesViewModel = ItunesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.artists.indices, id: \.self) { index in
                    let artist = viewModel.artists[index]
                    HStack {
                        if let artworkUrl = artist.artworkUrl60 {
                            Image.fromURL(artworkUrl)
                                .frame(width: 50, height: 50)
                                .border(Color.gray)
                                .padding(.trailing, 10)
                        }
                        VStack(alignment: .leading) {
                            if let artistName = artist.artistName {
                                Text(artistName)
                                    .bold()
                                    .lineLimit(2)
                            }
                            if let genreName = artist.primaryGenreName {
                                Text(genreName)
                                    .lineLimit(1)
                            }
                        }
                        .padding(.trailing, 30)
                        Spacer()
                        if let collectionPrice = artist.collectionPrice {
                            Text(String(format: "$%.2f", collectionPrice))
                                .foregroundColor(.blue)
                                .frame(width: 70, height: 30)
                                .border(Color.blue, width: 2)
                        }
                    }
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 0.5)
                            .frame(height: 0.5),
                        alignment: .bottom
                    )
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewModel.fetchArtists(from: Constants.urlString.rawValue)
        }
        
    }
}

#Preview {
    ItunesHomeView()
}
