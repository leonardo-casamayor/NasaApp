//
//  PopularViewControllerTests.swift
//  Nasa AppTests
//
//  Created by Miguel Arturo Ruiz Martinez on 19/10/21.
//

import XCTest
@testable import Nasa_App

class PopularViewControllerTests: XCTestCase {
    
    var sut: PopularViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PopularViewController()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_PopulateMedia_ReturnsNasaData() throws {
        // Given
        let promise = expectation(description: "Data loaded")
        let queryDictionary = MediaApiConstants.defaultPopularSearch
        // When
        sut.dataLoader.retrieveMedia(queryDictionary: queryDictionary) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    promise.fulfill()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    XCTFail("no response from API")
                }
            }
        }
        // Then
        wait(for: [promise], timeout: 5)
    }
    
}
