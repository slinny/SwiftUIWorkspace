//
//  Extensions.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/9/24.
//

import SwiftUI

extension Image {
    static func fromURL(_ urlString: String, placeholder: Image = Image(systemName: "photo")) -> some View {
        AsyncImage(urlString: urlString, placeholder: placeholder)
    }
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    init(urlString: String, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
                    .resizable()
            }
        }
        .task {
            await loader.load()
        }
    }
}

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }

    func load() async {
        guard let url = URL(string: urlString) else {
            print(URLError(.badURL))
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let loadedImage = UIImage(data: data) {
                self.image = loadedImage
            } else {
                print("Failed to convert data to UIImage.")
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}

