//
//  DispatchQueue.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 7/12/24.
//

import Foundation
import UIKit

class ImageDownloader {
    private let downloadQueue = DispatchQueue(label: "com.example.downloadQueue", attributes: .concurrent)
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        downloadQueue.async {
            // Perform the download task
            var image: UIImage? = nil
            if let data = try? Data(contentsOf: url) {
                image = UIImage(data: data)
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

// Usage example in a view controller
class ViewController: UIViewController {
    let imageView = UIImageView()
    let downloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        if let url = URL(string: "https://example.com/image.png") {
            downloader.downloadImage(from: url) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }
}



