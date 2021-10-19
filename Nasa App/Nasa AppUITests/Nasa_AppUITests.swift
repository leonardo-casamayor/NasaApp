//
//  Nasa_AppUITests.swift
//  Nasa AppUITests
//
//  Created by David Felipe Lizarazo Velandia on 10/08/21.
//

import XCTest
var app: XCUIApplication!

class Nasa_AppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_PopularTab_CellDetailShouldExist() throws {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Popular"].tap()
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstChild.exists {
            firstChild.tap()
        }
    }
    
}
