//
//  RoverModel.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 22/09/21.
//

import Foundation

// MARK: - NasaRover
struct NasaRover: Codable {
    var latestPhotos: [LatestPhoto]

    enum CodingKeys: String, CodingKey {
        case latestPhotos = "latest_photos"
    }
}

// MARK: - LatestPhoto
struct LatestPhoto: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
