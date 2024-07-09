//
//  AsyncImageView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/2/24.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        AsyncImage(urlString: "")
            .frame(width: 50, height: 50)
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .padding(10)
    }
}

#Preview {
    AsyncImageView()
}
