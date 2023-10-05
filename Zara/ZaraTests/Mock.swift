//
//  Mock.swift
//  ZaraTests
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import Foundation
@testable import Zara

class CharacterListUseCaseMock: CharacterListUseCase {
    func fetchCharacterList(completion: @escaping ([Character]?, Error?) -> Void) {
        // Simulate an empty response by returning an empty list of characters
        completion([], nil)
    }
}

class NetworkServiceMock: NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        // Simula una respuesta exitosa con datos vacíos
        let emptyResponse = ApiResponse(results: [])
        completion(.success(emptyResponse as! T))
    }
}

class NetworkServiceMockWithResult: NetworkServiceMock {
    var mockResult: Result<[Character], Error>?

    override func request<T: Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let mockResult = mockResult as? Result<T, Error> {
            completion(mockResult)
        } else {
            if responseType == ApiResponse.self {
                // Simulate a successful response with empty data
                let emptyResponse = ApiResponse(results: [])
                completion(.success(emptyResponse as! T))
            } else {
                super.request(url: url, method: method, responseType: responseType, completion: completion)
            }
        }
    }
}

class RealNetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let jsonString = """
        {
            "characters": [
                {
                    "name": "Character1",
                    "species": "Species1",
                    "gender": "Gender1",
                    "origin": {
                        "name": "Origin1",
                        "url": "URL1"
                    },
                    "image": "Image1"
                },
                {
                    "name": "Character2",
                    "species": "Species2",
                    "gender": "Gender2",
                    "origin": {
                        "name": "Origin2",
                        "url": "URL2"
                    },
                    "image": "Image2"
                }
            ]
        }
        """
        
        // Convert the JSON string to data and decode it into the specified model type
        let jsonData = jsonString.data(using: .utf8)
        let decoder = JSONDecoder()
        do {
            let parsedResponse = try decoder.decode(T.self, from: jsonData!)
            completion(.success(parsedResponse))
        } catch {
            completion(.failure(error))
        }
    }
}
