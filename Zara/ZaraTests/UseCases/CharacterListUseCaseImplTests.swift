//
//  CharacterListUseCaseImplTests.swift
//  ZaraTests
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import XCTest
@testable import Zara

class CharacterListUseCaseImplTests: XCTestCase {
    var characterListUseCase: CharacterListUseCase!

    // Set up the use case instance to use the network service mock
    override func setUp() {
        super.setUp()
        let networkService = NetworkServiceMock()
        characterListUseCase = CharacterListUseCaseImpl(networkService: networkService)
    }

    // Clean up resources
    override func tearDown() {
        characterListUseCase = nil
        super.tearDown()
    }

    // Test the use case when an empty response is obtained
    func testFetchCharacterListEmptyResponse() {
        // Create a mock of CharacterListUseCase to simulate an empty response
        let characterListUseCase = CharacterListUseCaseMock()
        
        // Create an expectation to wait for the asynchronous code to complete
        let expectation = self.expectation(description: "Fetch Character List")

        // Call the fetchCharacterList method on the mock use case
        characterListUseCase.fetchCharacterList { (characters, error) in
            // Check if the 'characters' result is not nil, indicating a non-nil response
            XCTAssertNotNil(characters, "Characters should not be nil")
            
            // Check if the 'error' result is nil, indicating no errors occurred
            XCTAssertNil(error, "Error should be nil")
            
            // Check if the count of characters in the response is 0
            XCTAssertEqual(characters?.count, 0, "Character count should be 0")

            // Fulfill the expectation to signal that the test is complete
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled, or a timeout of 5 seconds
        waitForExpectations(timeout: 5, handler: nil)
    }



    // Test the use case when a successful response with characters is obtained
    func testFetchCharacterSuccess() {
        let networkService = NetworkServiceMockWithResult()
        let characterListUseCase = CharacterListUseCaseImpl(networkService: networkService)
        let expectation = self.expectation(description: "Fetch Character List")

        // Define the expected characters for the test
        let expectedCharacters: [Character] = [
            Character(name: "Character1", species: "Species1", gender: "Gender1", origin: Origin(name: "Origin1", url: "URL1"), image: "Image1"),
            Character(name: "Character2", species: "Species2", gender: "Gender2", origin: Origin(name: "Origin2", url: "URL2"), image: "Image2")
        ]

        // Simulate a successful network request result in the custom mock
        networkService.mockResult = .success(expectedCharacters)

        characterListUseCase.fetchCharacterList { (character, error) in
            XCTAssertNotNil(character, "Characters should not be nil")
            XCTAssertNil(error, "Error should be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}


