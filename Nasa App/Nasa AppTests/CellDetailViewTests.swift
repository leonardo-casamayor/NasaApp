//
//  CellDetailViewTests.swift
//  Nasa AppTests
//
//  Created by Miguel Arturo Ruiz Martinez on 18/10/21.
//

import XCTest
@testable import Nasa_App

class CellDetailViewTests: XCTestCase {
    
    var sut: CellDetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CellDetailViewController()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_SetUpPopular_ReturnsValuesFromAPI() throws {
        // Given
        sut.href = "https://images-assets.nasa.gov/image/PIA09654/collection.json"
        let promise = expectation(description: "Data loaded")
        // When
        sut.networkManager.retrieveAssets(assetsUrl: sut.href!) { result in
            switch result {
            case .success(let urls):
                guard !urls.isEmpty else { return XCTFail("no URLS found in response") }
                DispatchQueue.main.async {
                    promise.fulfill()
                }
            case .failure(_):
                XCTFail("no response from API")
            }
        }
        // Then
        wait(for: [promise], timeout: 5)
    }
    
    func test_Render_CellDetailView() {
        // Given
        sut.assetUrl = "https://images-assets.nasa.gov/image/PIA09654/collection.json"
        sut.nasaDate = "12-12-12"
        sut.nasaTitle = "test"
        sut.nasaDescription = "test description"
        sut.mediaType = MediaType.image
        // When
        sut.loadView()
        // Then
        XCTAssertEqual(sut.assetUrl, "https://images-assets.nasa.gov/image/PIA09654/collection.json", "assetURL is not equal")
        XCTAssertEqual(sut.nasaDate, "12-12-12", "nasaDate is not equal")
        XCTAssertEqual(sut.nasaTitle, "test", "nasaTitle is not equal")
        XCTAssertEqual(sut.nasaDescription, "test description", "nasaDescription is not equal")
        XCTAssertEqual(sut.mediaType, MediaType.image, "mediaType is not Equal")
    }
    
}
