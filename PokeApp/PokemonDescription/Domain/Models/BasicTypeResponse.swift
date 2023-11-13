//
//  BasicTypeResponse.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 11/11/23.
//

import Foundation

struct BasicTypeResponse: Codable, Hashable {
    var slot: Int
    var type: BasicType
}
