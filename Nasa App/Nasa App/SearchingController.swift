//
//  SearchingController.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 20/09/2021.
//

import Foundation

protocol SearchingFacade {
    typealias result<NasaImageVideoLibrary> = (Result<NasaImageVideoLibrary, Error>) -> Void
    var media: NasaImageVideoLibrary? { get set }
    func retrieveMedia(queryDictionary: [String:String],
                       completion: @escaping result<NasaImageVideoLibrary>)
}

class SearchingController: SearchingFacade {
    typealias result<NasaImageVideoLibrary> = (Result<NasaImageVideoLibrary, Error>) -> Void
    
    var media: NasaImageVideoLibrary?
    
    /// Retrieve Media
    /// - Parameters:
    ///   - queryDictionary: [String:String] dictionary to generate the query
    ///   - completion: on Success will retrieve and allow usage of media, on failure can return an error
    func retrieveMedia(queryDictionary: [String:String],
                       completion: @escaping result<NasaImageVideoLibrary>) {
        let dataManager = DataLoader()
        dataManager.request(of: NasaImageVideoLibrary.self,
                            endpoint: ApiQuery.generateURL(api: APIadress.mediaLibrary,
                                                           endpoint: EndpointAdress.search,
                                                           queryType: QueryType.complexQuery,
                                                           queryDictionary: queryDictionary).url) {
            [weak self] result in
            DispatchQueue.global().async {
                switch result {
                case.success(let media):
                    self?.media = media
                    completion(result)
                case .failure(_):
                    print("error")
                    completion(result)
                }
            }
        }
    }
}

