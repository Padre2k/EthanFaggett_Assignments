//
//  PocketMonsterUITests.swift
//  PocketMonsterUITests
//
//  Created by Ethan Faggett on 4/26/22.
//

import XCTest

class PocketMonsterUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()

    
        
//        let app = XCUIApplication()
//        let element = app.tables.cells["Bulbasaur"].children(matching: .other).element(boundBy: 0).children(matching: .other).element
//        element.tap()
//        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).element.tap()
//        app.staticTexts["bulbasaur"].tap()
//        app.staticTexts["overgrow"].tap()
//        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["PokeDex"].tap()
//
//        let pokedexNavigationBar = app.navigationBars["PokeDex"]
//        let searchPokemonSearchField = pokedexNavigationBar.searchFields["Search pokemon"]
//        searchPokemonSearchField.tap()
//        searchPokemonSearchField.tap()
//        element.tap()
//        pokedexNavigationBar.buttons["PokeDex"].tap()
//        searchPokemonSearchField.tap()
//        pokedexNavigationBar.buttons["Cancel"].tap()
  
        
        let app = XCUIApplication()
        sleep(30)
        app.tables.cells["Venusaur"].children(matching: .other).element(boundBy: 0).children(matching: .key).element.tap()
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["PokeDex"].tap()
        
        
        
    
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
