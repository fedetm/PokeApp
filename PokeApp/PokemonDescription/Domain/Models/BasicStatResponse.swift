//
//  BasicStatResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/13/23.
//

import Foundation

struct BasicStatResponse: Codable, Hashable {
    
    var baseStat: Int
    var effort: Int
    var stat: BasicStat
    
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
}
