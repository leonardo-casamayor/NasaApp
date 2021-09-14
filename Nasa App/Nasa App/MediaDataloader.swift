//
//  MediaNetworkManager.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 05/09/2021.
//
import Foundation

protocol NetworkingFacade {
    func request(endpoint: ApiSearch)
}

class DataLoader: NetworkingFacade {
    func request(endpoint: ApiSearch) {
        guard let url = endpoint.url else {
            print("url error:\(String(describing: endpoint.url))")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let myResponse = response as? HTTPURLResponse,
                  myResponse.statusCode == 200,
                  let myData = data else {
                if let myResponse = response as? HTTPURLResponse {
                    switch myResponse.statusCode {
                    case 300...399:
                        print("serverside error")
                    case 400...499:
                        print("bad request")
                    case 500...599:
                        print("server internal error")
                    default:
                        print("something else \(myResponse)")
                    }
                }
                return
            }
            print(myData)
            let JSON = handle(data: myData)
            print("Json:\(JSON.debugDescription)")
        }
        task.resume()
    }
}
func handle(data: Data) -> [String: Any]? {
    try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
}
