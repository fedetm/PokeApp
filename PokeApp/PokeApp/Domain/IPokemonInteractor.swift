//
//  IPokemonInteractor.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

protocol IPokemonInteractor {
    
    func getPokemonsAndGenerations()
    
    func getPokemonImageAndBaseExperience(pokemonURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void)
    
    func getPokemonImageAndBaseExperience(specieURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void)
    
    func getSelectedPokemon(pokemonURL urlString: String, completion: @escaping (_ pokemon: Pokemon, _ data: Data) -> Void)
    
}
