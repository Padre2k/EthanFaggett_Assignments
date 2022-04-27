//
//  ImageDisplayAppTests.swift
//  ImageDisplayAppTests
//
//  Created by Ethan Faggett on 4/25/22.
//

import XCTest
@testable import ImageDisplayApp

class ImageDisplayAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDidImageDataViewLoad() {
//        class fakeImageViewData {
//            var getFakeImageDataWasCalled = false
//        }
//
//
//        let viewController = ViewController()
//        viewController.getFakeImageData = fakeImageViewData()
       //Arrange
        let sut = ImageAppValidator()
        
        //Act
        sut.didImageLoad()
        
    }
}
