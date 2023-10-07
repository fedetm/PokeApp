//
//  PokemonGenerationResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/3/23.
//

import Foundation

struct PokemonGenerationResponse: Codable {
    
    var count: Int
    var generations: [PokemonGeneration]
    
    enum CodingKeys: String, CodingKey {
        case count
        case generations = "results"
    }
    
}
