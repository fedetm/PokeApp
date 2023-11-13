//
//  BasicAbilityResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation

struct BasicAbilityResponse: Codable, Hashable {
    
    var ability: BasicAbility
    var isHidden: Bool
    var slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
}
