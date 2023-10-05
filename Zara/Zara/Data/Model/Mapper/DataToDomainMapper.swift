//
//  DataDomainMapper.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 2/10/23.
//

import Foundation

class DataToDomainMapper {
    static func mapCharacter(dataModel: CharacterDataModel) -> Character {
        let originDomain = mapOrigin(dataModel.origin)
        return Character(
            name: dataModel.name,
            species: dataModel.species,
            gender: dataModel.gender,
            origin: originDomain,
            image: dataModel.image
        )
    }

    static func mapOrigin(_ dataModel: OriginDataModel) -> Origin {
        return Origin(name: dataModel.name, url: dataModel.url)
    }
}

