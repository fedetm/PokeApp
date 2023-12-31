//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/2/23.
//

import Foundation

class PokemonRepository: IPokemonRepository {
    
    var dataSource: PokemonDataSource
    
    init() {
        self.dataSource = PokemonDataSource()
    }
    
    func getPokemons(completion: @escaping (_ pokemons: [BasicPokemon]) -> Void) {
        dataSource.getPokemons { response in
            completion(response.results)
        }
    }
    
    func getPokemon(from url: URL, completion: @escaping (_ pokemon: Pokemon) -> Void) {
        dataSource.getPokemon(from: url, completion: completion)
    }
    
    func getPokemonType(by id: Int, completion: @escaping (_ pokemonType: PokemonType) -> Void) {
        dataSource.getPokemonType(by: id, completion: completion)
    }
    
    func getGenerations(completion: @escaping (_ generations: [BasicPokemonGeneration]) -> Void) {
        dataSource.getGenerations { response in
            completion(response.generations)
        }
    }
    
    func getPokemonsByGeneration(id: Int, completion: @escaping (_ pokemons: [PokemonSpecieResponse]) -> Void) {
        dataSource.getPokemonsByGeneration(id: id) { pokemonsByGeneration in
            completion(pokemonsByGeneration.pokemonSpecies)
        }
    }
    
    func getPokemonImage(from url: URL, completion: @escaping (_ data: Data) -> Void) {
        dataSource.getPokemonImage(from: url, completion: completion)
    }
    
    func getPokemonSpecie(from url: URL, completion: @escaping (_ specie: PokemonSpecie) -> Void) {
        dataSource.getPokemonSpecie(from: url, completion: completion)
    }
    
}
