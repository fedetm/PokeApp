//
//  PokemonDescriptionRepository.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/28/23.
//

import Foundation

class PokemonDescriptionRepository: IPokemonDescriptionRepository {
    
    var dataSource: PokemonDescriptionDataSource
    
    init() {
        dataSource = PokemonDescriptionDataSource()
    }
    
    func getSprite(from url: URL, completion: @escaping (_ data: Data) -> Void) {
        dataSource.getSprite(from: url, completion: completion)
    }
    
}
