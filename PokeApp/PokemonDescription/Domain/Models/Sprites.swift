//
//  Sprites.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/21/23.
//

import Foundation

struct Sprites: Codable, Hashable {
    var backDefault: String
    var backShiny: String
    var frontDefault: String
    var frontShiny: String
    var other: Other
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case other
    }
}

struct Other: Codable, Hashable {
    var officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable, Hashable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
