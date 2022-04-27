//
//  PocketMonsterTests.swift
//  PocketMonsterTests
//
//  Created by Ethan Faggett on 4/26/22.
//

import XCTest
@testable import PocketMonster

class PocketMonsterTests: XCTestCase {

   // private var subscribers = Set<AnyCancellable>()
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSample() throws {
        // UI tests must launch the application that they test.
                          

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    @MainActor func testGetPokemons_Success() async throws {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        let data = try await getDataFrom(jsonFile: "PokemonResponse")
        fakeNetworkManager.data = data
      //  let remote = RemoteRepository(networkManager: fakeNetworkManager)
      //  let repository = Repository(remote: remote, local: nil)
        let viewModel = PokemonListViewModel()
        let expectation = expectation(description: "waiting for publisher")
        var pokemons: [Pokemon] = []
        
        //When
        do {
            try await viewModel.loadPokemons()
            viewModel
                .$pokemons
                .sink { result in
                    pokemons =  result.map {
                        let newItem = Pokemon(name: $0.name, urlDetails: $0.imgURL)
                        return newItem
                    } //result
                    expectation.fulfill()
                }
           //     .store(in: &subscribers)
        } catch (let error) {
            print(error.localizedDescription)
        }
        
        
        //Then
        waitForExpectations(timeout: 2.0)
        XCTAssertEqual(pokemons.count, 100)
        XCTAssertTrue(pokemons.first?.name == "bulbasaur")
    }


    private func getDataFrom(jsonFile: String) async throws -> Data {
        let bundle = Bundle(for:PokemonListViewModel.self)
        guard let url = bundle.url(forResource: jsonFile, withExtension: "json")
        else { return Data() }
        return try Data(contentsOf: url)
    }
    
}
