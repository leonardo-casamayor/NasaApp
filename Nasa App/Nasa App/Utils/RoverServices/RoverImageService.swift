//
//  RoverImageService.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 23/09/21.
//

import Foundation
import UIKit

// MARK: Get Images
extension UIImageView {
    func downloadedFrom(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloadedFrom(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(from: url, contentMode: mode)
    }
}

