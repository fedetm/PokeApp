//
//  BasicPokemonSpecie.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/7/23.
//

import Foundation

struct BasicPokemonSpecie: Codable, Hashable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
