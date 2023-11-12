//
//  BasicPokemonTypeResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/11/23.
//

import Foundation

struct BasicPokemonTypeResponse: Codable, Hashable {
    var slot: Int
    var type: BasicPokemonType
}
