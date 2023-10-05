//
//  CharacterSearchUseCaseImpl.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import Foundation

class CharacterSearchUseCaseImpl: CharacterSearchUseCase {
    private let characterListUseCase: CharacterListUseCase

    init(characterListUseCase: CharacterListUseCase) {
        self.characterListUseCase = characterListUseCase
    }
    
    func searchCharacters(with query: String, completion: @escaping ([Character]?, Error?) -> Void) {
        characterListUseCase.fetchCharacterList { [weak self] characters, error in
            guard self != nil else {
                completion(nil, AppError.noData)
                return
            }

            if let error = error {
                completion(nil, error)
                return
            }
            
            guard var characterList = characters else {
                completion(nil, AppError.noData)
                return
            }
            
            if query.isEmpty {
                // If the query is empty, display the complete list unchanged
                completion(characterList, nil)
                return
            }
            
            let lowercaseQuery = query.lowercased()
            characterList = characterList.filter { character in
                // Filters characters whose names contain the search text
                return character.name.lowercased().contains(lowercaseQuery)
            }
            
            completion(characterList, nil)
        }
    }
}


