//
//  IPokemonRepository.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

protocol IPokemonRepository {
    
    func getPokemons(completion: @escaping (_ pokemons: [BasicPokemon]) -> Void)
    
    func getPokemon(from url: URL, completion: @escaping (_ pokemon: Pokemon) -> Void)
    
    func getPokemonType(by id: Int, completion: @escaping (_ pokemonType: PokemonType) -> Void)
    
    func getGenerations(completion: @escaping (_ generations: [BasicPokemonGeneration]) -> Void)
    
    func getPokemonsByGeneration(id: Int, completion: @escaping (_ pokemons: [BasicPokemon]) -> Void)
    
    func getPokemonImage(from url: URL, completion: @escaping (_ data: Data) -> Void)
    
}
