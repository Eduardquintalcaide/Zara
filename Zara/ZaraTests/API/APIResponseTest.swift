//
//  APIResponseTest.swift
//  ZaraTests
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import XCTest
@testable import Zara

class APIResponseTest: XCTestCase {
    
    func testParseCharacterDataFromJSON() {
        // Load JSON data from the file
        if let data = loadJSONDataFromFile(named: "characters") {
            do {
                // Try to parse the data into a structure that matches the real response
                let decoder = JSONDecoder()
                let characterData = try decoder.decode(ApiResponse.self, from: data)
                
                // You can now make assertions on the `characterData` structure
                XCTAssertGreaterThan(characterData.results.count, 0, "There should be at least one character")
                XCTAssertEqual(characterData.results[0].name, "Rick Sanchez", "Name is Rick Sanchez")
            } catch {
                XCTFail("Failed to parse JSON data: \(error)")
            }
        } else {
            XCTFail("Failed to load JSON data from the file")
        }
    }
    
    func loadJSONDataFromFile(named fileName: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
                            
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            return nil
        }
    }
}




