//
//  ApodModel.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 15/09/2021.
//

import Foundation
import UIKit

struct APODElement: Codable {
    let date, explanation: String
    let hdurl: String?
    let mediaType: ApodMediaType
    let title: String
    let url: String?
    let copyright: String?
    let thumbnailUrl: String?
    var apodImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, title, url, copyright
        case mediaType = "media_type"
        case thumbnailUrl = "thumbnail_url"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try? container.decodeIfPresent(String.self, forKey: .url)
        guard let stringUrl = self.url else { return }
        guard let url: URL = URL(string: stringUrl) else { return }
        loadImage(url) { result in
            
            apodImage = result
        }
    }
    
    mutating func loadImage(_ urlString: URL, completion: @escaping (_ Image: UIImage) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        let downloadImageTask = session.dataTask(with: urlString) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let imageData = data, let image = UIImage(data: imageData)  else {
                    completion(#imageLiteral(resourceName: "Loading"))
                    return
                }
                    
                    completion(image)
                    
                }
            session.finishTasksAndInvalidate()
            }
        downloadImageTask.resume()
        }
}

enum ApodMediaType: String, Codable {
    case image = "image"
    case video = "video"
}


typealias Apod = [APODElement]


    


