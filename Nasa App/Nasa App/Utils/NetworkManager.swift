//
//  NetworkManager.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 09/09/2021.
//

import Foundation

protocol ApodClient {
    func retrieveApodData()
}

class NetworkManager {
    static func encodeURL(urlString: String) -> String? {
        urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    static func handle(data: Data) -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}

extension NetworkManager: ApodClient {
    func retrieveApodData() {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&thumbs=true"

        guard let queryString = NetworkManager.encodeURL(urlString: urlString) else {
            print("Bad URL")
            return
        }
        guard let url = URL(string: queryString) else {
            print("Bad URL")
            return
        }


        let session = URLSession.shared

        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request){ (data, response, error) in
            
            guard let dataUnwrap = data, error == nil else {
//                print(error.debugDescription)
                return }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let stausCode = httpResponse.statusCode
                switch stausCode {
                case 400:
                    print("Bad request")
                case 403:
                    print("Invalid api key")
                case 404:
                    print("Resource Not Found")
                case 200..<300:
                    if let limitReamining = httpResponse.value(forHTTPHeaderField: "X-RateLimit-Remaining"),
                       let json = NetworkManager.handle(data: dataUnwrap){
                        print("X-RateLimit-Remaining: \(limitReamining)")
                        print("Data: \(json)")
                    }
                case 500..<600:
                    print("Server error")
                default:
                    print("Unexpected Error")
                }
            }
        }
        task.resume()
    }
}

