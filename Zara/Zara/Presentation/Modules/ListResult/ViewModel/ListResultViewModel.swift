//
//  ListResultViewModel.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import Foundation

class ListResultViewModel {
    
    // The list of characters to display
    var result: [Character] = []
    
    // The list of characters used for searching
    private var originalCharacterList: [Character] = []
    
    let coordinator = ListResultViewModelCoordinator()
    
    // Fetch the list of characters
    func fetchResult(completion: @escaping () -> Void) {
        // Use the character list use case to retrieve characters
        coordinator.characterListUseCase.fetchCharacterList { [weak self] characters, error in
            if let characters = characters {
                self?.result = characters
                self?.originalCharacterList = characters
            }
            completion()
        }
    }
    
    // Search for characters based on a query
    func searchCharacters(with query: String, completion: @escaping () -> Void) {
        coordinator.characterSearchUseCase.searchCharacters(with: query) { [weak self] characters, error in
            if let characters = characters {
                self?.result = characters
            }
            completion()
        }
    }
}






