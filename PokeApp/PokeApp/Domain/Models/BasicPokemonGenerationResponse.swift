//
//  BasicPokemonGenerationResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/3/23.
//

import Foundation

struct BasicPokemonGenerationResponse: Codable {
    
    var count: Int
    var generations: [BasicPokemonGeneration]
    
    enum CodingKeys: String, CodingKey {
        case count
        case generations = "results"
    }
    
}
