//
//  Variety.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/24/23.
//

import Foundation

struct Variety: Codable, Hashable {
    
    var isDefault: Bool
    var pokemon: BasicPokemon
    
    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
    
}
