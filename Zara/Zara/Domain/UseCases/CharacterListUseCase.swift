//
//  CharacterListUseCase.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import Foundation

protocol CharacterListUseCase {
    func fetchCharacterList(completion: @escaping ([Character]?, Error?) -> Void)
}
