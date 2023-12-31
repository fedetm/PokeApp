//
//  PokemonsByGenerationResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/7/23.
//

import Foundation

struct PokemonsByGenerationResponse: Codable, Hashable {
    var id: Int
    var name: String
    var pokemonSpecies: [PokemonSpecieResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokemonSpecies = "pokemon_species"
    }
}

struct PokemonSpecieResponse: Codable, Hashable {
    var name: String
    var pokemonSpecieURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case pokemonSpecieURL = "url"
    }
}
