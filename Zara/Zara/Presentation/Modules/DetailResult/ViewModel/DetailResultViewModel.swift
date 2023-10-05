//
//  DetailResultViewModel.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 3/10/23.
//

import Foundation
import UIKit

class DetailResultViewModel {
    
    // Character to display details for
    var character: Character
    
    init(resultDetail: Character) {
        self.character = resultDetail
    }
    
    // Computed properties to retrieve character details
    var name: String {
        return character.name
    }
    
    var species: String {
        return character.species
    }
    
    var gender: String {
        return character.gender
    }
    
    var origin: Origin {
        return character.origin
    }
    
    var originalimageURL: URL? {
        return URL(string: character.image)
    }
}
