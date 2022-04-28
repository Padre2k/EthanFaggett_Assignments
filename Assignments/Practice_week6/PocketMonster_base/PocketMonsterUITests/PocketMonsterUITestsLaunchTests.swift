//
//  PocketMonsterUITestsLaunchTests.swift
//  PocketMonsterUITests
//
//  Created by Ethan Faggett on 4/26/22.
//

import XCTest

class PocketMonsterUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
        
//        let app = XCUIApplication()
//        app.launch()
        
        // validating table view
        let tablesQuery = app.tables
        let tableView = tablesQuery["table_view_stories"]
        XCTAssertTrue(tableView.exists)
        
        // validate first element
        let firstelement = tableView.staticTexts["Bulbasaur"]
        XCTAssertTrue(firstelement.exists)
                       
//        let searchField = app.searchFields
//        let searchQuery = app.searchFields
//        let searchFields = searchQuery["searchText"]
//        XCTAssertTrue(searchFields.exists)
//
        let theSearchField = app.searchFields  //searchFields()[""]
        XCTAssertTrue(theSearchField.element.exists)
        theSearchField.element.tap()
        
        
    }
    
    func testImageLoad() {
        
        let app = XCUIApplication()
        app.launch()

        
        let images = app.scrollViews["Pokemon"].children(matching: .image)
        XCTAssertTrue(images.element.exists)
    }
}
