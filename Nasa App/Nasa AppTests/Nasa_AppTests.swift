//
//  Nasa_AppTests.swift
//  Nasa AppTests
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import XCTest
@testable import Nasa_App

class ServiceTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_PopularAPICall_ReturnsHTTPStatusCode200() throws {
        // given
        let urlString = "https://images-api.nasa.gov/search?media_type=image,video&q=popular"
        guard let url = URL(string: urlString) else { return }
        let promise = expectation(description: "Status code: 200")
        // when
        let dataTask = sut.dataTask(with: url) { _, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
}

