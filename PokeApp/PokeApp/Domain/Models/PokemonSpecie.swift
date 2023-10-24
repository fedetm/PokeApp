//
//  PokemonSpecie.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/24/23.
//

import Foundation

struct PokemonSpecie: Codable, Hashable {
    
    var id: Int
    var name: String
    var baseHappiness: Int
    var captureRate: Int
    var genderRate: Int
    var varieties: [Variety]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case genderRate = "gender_rate"
        case varieties
    }
    
}
