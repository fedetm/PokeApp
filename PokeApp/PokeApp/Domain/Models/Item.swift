//
//  Item.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

enum Item: Hashable {
    case pokemon(BasicPokemon)
    case firstPokemonGeneration(PokemonSpecieResponse)
    case generation(BasicPokemonGeneration)
    
    var pokemon: BasicPokemon? {
        if case .pokemon(let pokemon) = self {
            return pokemon
        } else {
            return nil
        }
    }
    
    var firstPokemonGeneration: PokemonSpecieResponse? {
        if case .firstPokemonGeneration(let firstPokemonGeneration) = self {
            return firstPokemonGeneration
        } else {
            return nil
        }
    }
    
    var generation: BasicPokemonGeneration? {
        if case .generation(let generation) = self {
            return generation
        } else {
            return nil
        }
    }
    
    static var promotedPokemons: [Item]!
    
    static var firstPokemonGeneration: [Item]!
    
    static var generations: [Item]!
    
}
