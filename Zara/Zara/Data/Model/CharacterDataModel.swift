//
//  Result.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import Foundation

struct CharacterDataModel: Codable {
    let name: String
    let species: String
    let gender: String
    let origin: OriginDataModel
    let image: String
}
