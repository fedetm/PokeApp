//
//  BasicPokemonResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

struct BasicPokemonResponse: Codable {
    
    var count: Int
    var next: String
    var previous: String?
    var results: [BasicPokemon]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
