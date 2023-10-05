//
//  CharacterSearchUseCase.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 4/10/23.
//

import Foundation

protocol CharacterSearchUseCase {
    func searchCharacters(with query: String, completion: @escaping ([Character]?, Error?) -> Void)
}
