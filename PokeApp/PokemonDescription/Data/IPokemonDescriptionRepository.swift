//
//  IPokemonDescriptionRepository.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/28/23.
//

import Foundation

protocol IPokemonDescriptionRepository {
    
    func getSprite(from url: URL, completion: @escaping (_ data: Data) -> Void)
    
}
