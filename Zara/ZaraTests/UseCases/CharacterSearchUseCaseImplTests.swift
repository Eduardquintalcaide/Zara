//
//  CharacterSearchUseCaseImplTests.swift
//  ZaraTests
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import XCTest
@testable import Zara

class CharacterSearchUseCaseImplTests: XCTestCase {
    var characterSearchUseCase: CharacterSearchUseCase!
    var characterListUseCase: CharacterListUseCase!

    // Set up the use case instances
    override func setUp() {
        super.setUp()
        characterListUseCase = CharacterListUseCaseImpl(networkService: NetworkServiceMock())
        characterSearchUseCase = CharacterSearchUseCaseImpl(characterListUseCase: characterListUseCase)
    }

    // Clean up resources
    override func tearDown() {
        characterSearchUseCase = nil
        characterListUseCase = nil
        super.tearDown()
    }

    // Test searching for characters with an empty query
    func testSearchCharactersEmptyQuery() {
        let expectation = self.expectation(description: "Search Characters with Empty Query")

        characterSearchUseCase.searchCharacters(with: "") { (characters, error) in
            XCTAssertNotNil(characters, "Characters should not be nil")
            XCTAssertNil(error, "Error should be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test searching for characters with a valid query
    func testSearchCharactersWithQuery() {
        let expectation = self.expectation(description: "Search Characters with Query")

        characterSearchUseCase.searchCharacters(with: "Rick") { (characters, error) in
            XCTAssertNotNil(characters, "Characters should not be nil")
            XCTAssertNil(error, "Error should be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test searching for characters with an invalid query
    func testSearchCharactersInvalidQuery() {
        let expectation = self.expectation(description: "Search Characters with Invalid Query")

        characterSearchUseCase.searchCharacters(with: "InvalidQuery123") { (characters, error) in
            XCTAssertNotNil(characters, "Characters should not be nil")
            XCTAssertNil(error, "Error should be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

