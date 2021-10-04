//
//  FavoriteModel.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 04/10/2021.
//

import Foundation

struct FavoriteModel: Codable {
    let nasaId: String
    let imageLink: String
    let videoLink: String?
    let thumbnailLink: String?
    let mediaType: FavoriteType
    let title: String
    let date: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case nasaId, imageLink, videoLink, mediaType, title, date, description, thumbnailLink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nasaId = try container.decode(String.self, forKey: .nasaId)
        videoLink = try container.decode(String.self, forKey: .videoLink)
        mediaType = try container.decode(FavoriteType.self, forKey: .mediaType)
        title = try container.decode(String.self, forKey: .title)
        date = try container.decode(String.self, forKey: .date)
        description = try container.decode(String.self, forKey: .description)
        imageLink = try container.decode(String.self, forKey: .description)
        thumbnailLink = try container.decode(String.self, forKey: .thumbnailLink)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(imageLink, forKey: .imageLink)
        try container.encode(nasaId, forKey: .nasaId)
        try container.encode(videoLink, forKey: .videoLink)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(description, forKey: .description)
        try container.encode(thumbnailLink, forKey: .thumbnailLink)
    }
    
}

enum FavoriteType: String, Codable {
    case image = "image"
    case video = "video"
}

