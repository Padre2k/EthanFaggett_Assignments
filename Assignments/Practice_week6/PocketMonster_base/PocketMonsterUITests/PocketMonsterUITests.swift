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
        let tablesQuery = app.tables
        let growlitheButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Growlithe"]/*[[".cells[\"Growlithe\"].buttons[\"Growlithe\"]",".buttons[\"Growlithe\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        growlitheButton.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Poliwrath"].swipeRight()/*[[".cells[\"Poliwrath\"].buttons[\"Poliwrath\"]",".swipeUp()",".swipeRight()",".buttons[\"Poliwrath\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        tablesQuery.cells["Abra"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        let image = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).element
        image.tap()
        app.staticTexts["abra"].swipeDown()
        image.swipeUp()
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["PokeDex"].tap()
        tablesQuery.cells["Arcanine"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        let pokedexNavigationBar = app.navigationBars["PokeDex"]
        let pokedexButton = pokedexNavigationBar.buttons["PokeDex"]
        pokedexButton.tap()
        growlitheButton.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Psyduck"]/*[[".cells[\"Psyduck\"].buttons[\"Psyduck\"]",".buttons[\"Psyduck\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Venomoth"]/*[[".cells[\"Venomoth\"].buttons[\"Venomoth\"]",".buttons[\"Venomoth\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Vileplume"]/*[[".cells[\"Vileplume\"].buttons[\"Vileplume\"]",".buttons[\"Vileplume\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery.cells["Golbat"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeDown()
        tablesQuery.cells["Ninetales"].children(matching: .other).element(boundBy: 2).children(matching: .other).element.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Vulpix"]/*[[".cells[\"Vulpix\"].buttons[\"Vulpix\"]",".buttons[\"Vulpix\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Butterfree"]/*[[".cells[\"Butterfree\"].buttons[\"Butterfree\"]",".buttons[\"Butterfree\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery.cells["Charmander"].children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeDown()
        
        let searchPokemonSearchField = pokedexNavigationBar.searchFields["Search pokemon"]
        searchPokemonSearchField.tap()
        tablesQuery.cells["Venomoth"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        pokedexButton.tap()
        searchPokemonSearchField.tap()
        pokedexNavigationBar.buttons["Cancel"].tap()
                
        
        
        
    
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
