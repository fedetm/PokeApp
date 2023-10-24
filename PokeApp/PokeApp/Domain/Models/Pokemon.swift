//
//  Pokemon.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/3/23.
//

import Foundation

struct Pokemon: Codable, Hashable {
    var id: Int
    var baseExperience: Int
    var height: Int
    var isDefault: Bool
    var locationAreaEncounters: String
    var name: String
    var order: Int
    var weight: Int
    var sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case id
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case name
        case order
        case weight
        case sprites
    }
}
