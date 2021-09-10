//
//  ViewController.swift
//  Nasa App
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - NasaRover
    struct NasaRover: Codable {
        let photos: [Photo]
    }
    
    // MARK: - Photo
    struct Photo: Codable {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRoverData()
    }
    
    // MARK: - Methods
    func getRoverData() {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=ezs9fJo4LZbTb4mHX9qdcclsfLNmxxsqJ6dAX2e5"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let myData = data else {
                print("data was nil")
                return
            }
            do {
                let nasaRover = try JSONDecoder().decode(NasaRover.self, from: myData)
                print(nasaRover)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }

}

