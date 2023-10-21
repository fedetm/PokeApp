//
//  PokemonsByGenerationResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/7/23.
//

import Foundation

struct PokemonsByGenerationResponse: Codable {
    var id: Int
    var name: String
    var pokemonSpecies: [BasicPokemon]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokemonSpecies = "pokemon_species"
    }
}
