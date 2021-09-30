//
//  RoverDataService.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 23/09/21.
//

import Foundation

// MARK: Get JSON Data
extension RoverViewController {
    func getPhotos(completed: @escaping () -> ()) {
        let url = URL(string: DetailPlaceholderInfo.roverUrl)
        guard let validURL = url else { return }
        let task = URLSession.shared.dataTask(with: validURL, completionHandler: { (data, response, error) in
            guard let fetchedData = data else { return }
            if error == nil {
                do {
                    self.roverPhotos = try JSONDecoder().decode(NasaRover.self, from: fetchedData)
                    guard let roverPhotos = self.roverPhotos else { return }
                    print("pics:", roverPhotos)
                    self.roverPhotos = roverPhotos
                } catch {
                    print("Parse Error", error)
                }
                completed()
            }
        })
        task.resume()
    }
}
