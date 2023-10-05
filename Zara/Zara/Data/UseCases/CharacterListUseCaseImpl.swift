//
//  CharacterListUseCaseImpl.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import Foundation

class CharacterListUseCaseImpl: CharacterListUseCase {
    private let networkService: NetworkServiceProtocol
    
    // Initialize the use case with a network service dependency
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // Fetch a list of characters
    func fetchCharacterList(completion: @escaping ([Character]?, Error?) -> Void) {
        guard let url = URL(string: APIEndpoint.characterList) else {
            // Handle error for an invalid URL
            completion(nil, AppError.invalidURL)
            return
        }
        
        // Try to load data from cache
        if let cachedData = ResponseCache.shared.cachedResponse(for: url.absoluteString) {
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: cachedData)
                // Map data models to domain models
                let characterList = apiResponse.results.map { DataToDomainMapper.mapCharacter(dataModel: $0) }
                completion(characterList, nil)
                return
            } catch {
                // If decoding cached response fails, continue with the network request.
            }
        }
        
        // Request data from the network service
        networkService.request(url: url, method: .get, responseType: ApiResponse.self) { result in
            switch result {
            case .success(let apiResponse):
                DispatchQueue.main.async {
                    // Map data models to domain models
                    let characterList = apiResponse.results.map { DataToDomainMapper.mapCharacter(dataModel: $0) }
                    completion(characterList, nil)
                    
                    // Cache the network response for future requests
                    if let responseData = try? JSONEncoder().encode(apiResponse) {
                        ResponseCache.shared.cacheResponse(responseData, for: url.absoluteString)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

