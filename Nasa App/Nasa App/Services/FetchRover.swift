//
//  fetchRover.swift
//  Nasa App
//
//  Created by Miguel Arturo Ruiz Martinez on 14/09/21.
//

import Foundation

class FetchRover {
    
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

