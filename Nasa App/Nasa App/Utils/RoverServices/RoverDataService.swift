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
        for rover in RoverUrls.allCases {
            let url = URL(string: rover.rawValue)
            guard let validURL = url else { return }
            let task = URLSession.shared.dataTask(with: validURL, completionHandler: { (data, response, error) in
                guard let fetchedData = data else { return }
                if error == nil {
                    do {
                        let fetchedData = try JSONDecoder().decode(NasaRover.self, from: fetchedData)
                        self.roverPhotos.append(contentsOf: fetchedData.latestPhotos)
                    } catch {
                        print("Parse Error", error)
                    }
                    completed()
                }
            })
            task.resume()
        }
    }
}
