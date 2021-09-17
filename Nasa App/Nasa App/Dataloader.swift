//
//  MediaNetworkManager.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 05/09/2021.
//
import Foundation

protocol NetworkingFacade {
    func request(endpoint: URL?)
}

class DataLoader: NetworkingFacade {
    func request(endpoint: URL?) {
        guard let url = endpoint else {
            print("url error:\(String(describing: endpoint))")
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            print("data: \(data.debugDescription)")
            print("response: \(response.debugDescription)")
            print("error: \(error.debugDescription)")
            if let error = error {
                switch (error as NSError).code {
                case NSURLErrorNetworkConnectionLost:
                    print("Connection Lost")
                    return
                case NSURLErrorCancelledReasonUserForceQuitApplication:
                    print("user quit the aplication")
                    return
                default:
                    print("other")
                    return
                }
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    print("should be okay")
                case 300...399:
                    print("serverside error")
                case 400...499:
                    print("bad request")
                case 500...599:
                    print("server internal error")
                default:
                    print("something else \(response)")
                }
            }
            if let data = data {
                let JSON = handle(data: data)
                print("stuff happened")
                print("Json:\(JSON.debugDescription)")
            }
        }
        task.resume()
    }
}
func handle(data: Data) -> [String: Any]? {
    try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
}
